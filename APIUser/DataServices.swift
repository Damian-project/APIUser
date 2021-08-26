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
    
    func createNewGits(completion: @escaping (Result<Any, Error>) -> Void) {
        
        let postComponents = createURLComponents(path: "/gists")
        guard let composedURL = postComponents.url else {
            print("URL creatoin failed")
            return
        }
        
        var  postRequest = URLRequest(url: composedURL)
        postRequest.httpMethod = "POST"
        
        let newGits = GitData(id: nil, isPublic: true, description: "A brand new gits", files: ["test_file.txt": File(content: "Hello World!")])
        
        do {
            let gitsData = try JSONEncoder().encode(newGits)
            postRequest.httpBody = gitsData
        } catch {
            print("Gits encoding failed")
        }
        
        URLSession.shared.dataTask(with: postRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse)")
            }
            
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: validData, options: [])
                completion(.success(json))
            } catch let serializationError {
                completion(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func createURLComponents(path: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = path
        
        return components
    }
}
