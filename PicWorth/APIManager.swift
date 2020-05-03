//
//  APIManager.swift
//  PicWorth
//
//  Created by Kun Huang on 5/1/20.
//  Copyright © 2020 Kun Huang. All rights reserved.
//

import Foundation

struct APIManager {
    
    public static let apiManager = APIManager()
    let baseURL = "https://api.datamuse.com/words?"
    
    enum APIError: Error {
        case invalidURL(reason: String)
        case someError(error: Error)
        case badData(reason: String)
    }
    
    func getDefinition(term: String, completion: @escaping (Result<[DefinitionData], APIError>) -> ()) {
        let apiURL = URL(string: baseURL + "sp=\(term)&md=d")
        let task = URLSession.shared.dataTask(with: apiURL!) { (data, response, error) in
            guard let dataJson = data else {
                completion(.failure(.invalidURL(reason: "invalid URL")))
                return
            }
            guard error == nil else {
                completion(.failure(.someError(error: error!)))
                return
            }
            do {
                let decoder = JSONDecoder()
                print("*****json")
                print(dataJson)
                //decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let eachData = try! JSONSerialization.jsonObject(with: dataJson, options: [])
//                print("*****each")
//                print(eachData)
                let definition = try decoder.decode(Array<DefinitionData>.self, from: dataJson)
                print("sadsd")
                completion(.success(definition))
            } catch {
                completion(.failure(.badData(reason: "bad data")))
            }
        }
        task.resume()
    }
}
