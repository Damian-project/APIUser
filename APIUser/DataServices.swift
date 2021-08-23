//
//  DataServices.swift
//  APIUser
//
//  Created by PC on 23/08/2021.
//

import Foundation

class DataService {
    static let shared = DataService()
    fileprivate let baseURLString = "https://api.github.com"
    
    func fetchData(completion: @escaping (Result<[GitData], Error>) -> Void) {
        //result is an enum type <Succes type, failure type>
        //@escaping allow execute after the method returns 
        
//        var baseURL = URL(string: baseURLString)
//        baseURL?.appendPathComponent("/somePath")
//
//        let compouseURL = URL(string: "/somePath", relativeTo: baseURL)
//
        var componentURL = URLComponents()
        componentURL.scheme = "https"
        componentURL.host = "api.github.com"
        componentURL.path = "/gists/public"
        
        guard let validURL = componentURL.url else {
            print("URL creation failed")
            return
        }
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let gitData = try JSONDecoder().decode([GitData].self, from: validData)
                completion(.success(gitData))
            } catch let serializationError {
                completion(.failure(serializationError))
            }
            
        }.resume()
        
    }
}
