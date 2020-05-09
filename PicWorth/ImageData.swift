//
//  ImageData.swift
//  PicWorth
//
//  Created by Kun Huang on 5/7/20.
//  Copyright © 2020 Kun Huang. All rights reserved.
//

import Foundation

struct ImageData: Codable {
    
    var id: Int
    var webformaturl: String
    var largeimageurl: String
    var userid: Int
    var user: String
    var userimageurl: String
    
}

struct ImageHits: Codable {
    var hits: [ImageData]
}
