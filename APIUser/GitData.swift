//
//  GitData.swift
//  APIUser
//
//  Created by PC on 23/08/2021.
//

import Foundation

struct GitData: Encodable {
    var id: String?
    var isPublic: Bool
    var description: String
    var files: [String: File]
    
    enum CodingKeys: String, CodingKey {
        case id, description, files, isPublic = "public"
        //each var must maching CodingKeys, so "id" at teh beginning line
    }
   
    func  encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(isPublic, forKey: .isPublic)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(files, forKey: .files)
    }
}
extension GitData: Decodable {
    
    //MARK:- description can be nil so that the solution
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //object holding CodingKeys and look up the actual properties in JSON
        
        self.id = try container.decode(String.self, forKey: .id)
        self.isPublic = try container.decode(Bool.self, forKey: .isPublic)
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? "Description is nil"
        self.files = try container.decode([String: File].self, forKey: .files)
    }
}


struct File: Codable {
    var content: String?
}
