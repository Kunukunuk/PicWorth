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
    private var imageData: ImageData
    
    init() {
        self.imageData = ImageData(id: 123, webformatURL: "", largeImageURL: "https://pixabay.com/static/img/public/medium_rectangle_b.png", userId: 123, user: "PixaBay", userImageURL: "")
        let url = URL(string: imageData.largeImageURL)!
        self.imageLoader = ImageLoader(url: url)
    }
    
    init(imageData: ImageData) {
        self.imageData = imageData
        let url = URL(string: imageData.largeImageURL)!
        imageLoader = ImageLoader(url: url)
    }
    var body: some View {
        VStack {
            if imageLoader.data != nil {
                Image(uiImage: UIImage(data: imageLoader.data!)!)
                    .resizable()
                    .frame(width: 200, height: 150)
                    .overlay(ImageOverlay(imageInfo: self.imageData), alignment: .bottomTrailing)
            } else {
                Image(uiImage: UIImage())
            }
        }
    }
}

struct ImageOverlay: View {
    
    var imageInfo: ImageData
    
    var body: some View {
        ZStack {
            Text("Photo by \(imageInfo.user)")
                .foregroundColor(Color.white)
                .padding(6)
        }
        .background(Color.black)
        .opacity(0.75)
        .cornerRadius(10)
        .padding(6)
    }
}
