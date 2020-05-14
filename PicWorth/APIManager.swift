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
    let dictionaryBaseURL = "https://api.datamuse.com/words?"
    let pixabayBaseURL = "https://pixabay.com/api/?"
    
    enum APIError: Error {
        case invalidURL(reason: String)
        case someError(error: Error)
        case JSONError(reason: String)
    }
    
    func getDefinition(term: String, completion: @escaping (Result<[DefinitionData], APIError>) -> () ) {
        let apiURL = URL(string: dictionaryBaseURL + "sp=\(term)&md=d")
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
                let definition = try decoder.decode(Array<DefinitionData>.self, from: dataJson)
                completion(.success(definition))
            } catch {
                completion(.failure(.JSONError(reason: "JSON can't decode")))
            }
        }
        task.resume()
    }
    
    func getImageHits(term: String, completion: @escaping (Result<[ImageData], APIError>) -> () ) {
        let apiURL = URL(string: pixabayBaseURL + "q=\(term)&page=1")
        let task = URLSession.shared.dataTask(with: apiURL!) { (data, response, error) in
            guard let dataJson = data else {
                completion(.failure(.invalidURL(reason: "invalid URL")))
                return
            }
            guard error == nil else {
                completion(.failure(.someError(error: error!)))
                return
            }
            
            guard let res = (response as? HTTPURLResponse)?.statusCode, 200 == res else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                //let dataDict = try! JSONSerialization.jsonObject(with: dataJson, options: []) as! [String: Any]
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let imagehits = try decoder.decode(ImageHits.self, from: dataJson)
                completion(.success(imagehits.hits))
            } catch {
                completion(.failure(.JSONError(reason: "Can't parse JSON correctly")))
            }
        }
        
        task.resume()
    }
}
