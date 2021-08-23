//
//  GitData.swift
//  APIUser
//
//  Created by PC on 23/08/2021.
//

import Foundation

struct GitData: Codable {
    var id: String
    var isPublic: Bool
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id, description, isPublic = "public"
        //each var must maching CodingKeys, so "id" at teh beginning line
    }
    //MARK:- description can be nil so that the solution
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //object holding CodingKeys and look up the actual properties in JSON
        
        self.id = try container.decode(String.self, forKey: .id)
        self.isPublic = try container.decode(Bool.self, forKey: .isPublic)
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? "Description is nil"
    }
}
