//
//  ImageLoader.swift
//  PicWorth
//
//  Created by Kun Huang on 5/5/20.
//  Copyright © 2020 Kun Huang. All rights reserved.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    
    @Published var data: Data?
    
    init(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct ImageView: View {
    
    @ObservedObject private var imageLoader: ImageLoader
    
    init(url: URL) {
        imageLoader = ImageLoader(url: url)
    }
    var body: some View {
        VStack {
            Image(uiImage: imageLoader.data != nil ? UIImage(data: imageLoader.data!)! : UIImage())
        }
    }
}
