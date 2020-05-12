//
//  CollectionView.swift
//  PicWorth
//
//  Created by Kun Huang on 5/10/20.
//  Copyright © 2020 Kun Huang. All rights reserved.
//

import SwiftUI
import UIKit

struct CollectionView: UIViewRepresentable {
    
    @Binding var imageData: [ImageData]?
//    @ObservedObject var imageLoaders: ImageLoader = ImageLoader(url: URL(string: "https://pixabay.com/static/img/public/medium_rectangle_b.png")!)
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.sectionHeadersPinToVisibleBounds = true
            let makeCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
            layout.scrollDirection = .vertical
            makeCV.translatesAutoresizingMaskIntoConstraints = false
            makeCV.backgroundColor = .clear
            makeCV.layer.borderColor = UIColor.green.cgColor
            makeCV.layer.borderWidth = 3.0
            makeCV.dataSource = context.coordinator
            makeCV.delegate = context.coordinator
            makeCV.register(CollectionViewCell.self, forCellWithReuseIdentifier: "ttc")
            return makeCV
        }()

        return collectionView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        uiView.reloadData()
    }
    
    class Coordinator: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
        var parent: CollectionView
        
        init(_ collectionView: CollectionView) {
            self.parent = collectionView
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return parent.imageData?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ttc", for: indexPath) as! CollectionViewCell
            if parent.imageData?.isEmpty ?? true {
                cell.customView?.rootView = ImageView(url: URL(string: "https://pixabay.com/static/img/public/medium_rectangle_b.png")!)
            } else {
                let t = parent.imageData?[indexPath.item]
                let tURL = URL(string: t!.largeImageURL)!
                //cell.imageData = t
                cell.customView?.rootView = ImageView(url: tURL)
            }
            return cell
        }
        
    }
}

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseId: String = "ttc"
//    var imageData: ImageData? {
//        didSet {
//            if let haveData = imageData {
//                let url = URL(string: haveData.largeImageURL)
//                image = ImageView(url: url!)
//            }
//        }
//    }
    
    
    public var image: ImageView = ImageView(url: URL(string: "https://pixabay.com/static/img/public/medium_rectangle_b.png")!)
    public var customView: UIHostingController<ImageView>?
    override init(frame: CGRect) {
        super.init(frame: .zero)
        customView = UIHostingController(rootView: image)
        customView!.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customView!.view)
        
        customView!.view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        customView!.view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        customView!.view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        customView!.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(imageData: .constant([ImageData(id: 123, webformatURL: "", largeImageURL: "https://pixabay.com/static/img/public/medium_rectangle_b.png", userId: 123, user: "", userImageURL: "")]))
    }
}
