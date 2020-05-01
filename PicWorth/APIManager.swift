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
        case invalidURL(error: Error)
        case networkError(error: Error)
    }
    
    func getDefinition(term: String, completion: @escaping (Result<Int, APIError>) -> ()) {
        
    }
}
