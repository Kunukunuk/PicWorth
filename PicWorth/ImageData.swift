//
//  ImageData.swift
//  PicWorth
//
//  Created by Kun Huang on 5/7/20.
//  Copyright © 2020 Kun Huang. All rights reserved.
//

import Foundation

struct ImageData: Codable, Hashable {
    
    var id: Int
    var webformatURL: String
    var largeImageURL: String
    var userId: Int
    var user: String
    var userImageURL: String
    
}

struct ImageHits: Codable {
    var hits: [ImageData]
}
