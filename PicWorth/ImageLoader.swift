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
    
    @Published var image: UIImage = UIImage()
    
    func loadImage(url: String) {
        let getURL = URL(string: url)!
        URLSession.shared.dataTask(with: getURL) { (data, response, error) in
            guard error == nil else {
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            self.image = image
        }.resume()
    }
}

//struct ViewImage: View {
//
//    @State var viewImage: Image
//    @ObservedObject var imageLoader: ImageLoader
//
//    init() {
//        self.viewImage = Image("")
//        self.imageLoader = ImageLoader()
//    }
//
//    var body: some View {
//        self.viewImage = Image(uiImage: imageLoader.image)
//        return self.viewImage
//    }
//}
