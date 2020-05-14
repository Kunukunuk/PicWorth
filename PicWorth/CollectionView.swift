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
            makeCV.layer.borderColor = UIColor.gray.cgColor
            makeCV.layer.borderWidth = 0.5
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
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let numberItemPerCell: CGFloat = 2

            if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
                
                flowLayout.minimumInteritemSpacing = 5
                flowLayout.minimumLineSpacing = 5
                
                let totalSpace = flowLayout.sectionInset.left
                    + flowLayout.sectionInset.right
                    + (flowLayout.minimumInteritemSpacing * numberItemPerCell - 1)

                let size = Int((collectionView.bounds.width - totalSpace) / numberItemPerCell)
                
                return CGSize(width: size, height: size )
            }
            return CGSize(width: 100, height: 100)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 5, left: 2.5, bottom: 5, right: 2.5)
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ttc", for: indexPath) as! CollectionViewCell
            if parent.imageData?.isEmpty ?? true {
                cell.customView?.rootView = ImageView()
            } else {
                
                let imageAtCell = parent.imageData?[indexPath.item]
                cell.customView?.rootView = ImageView(imageData: imageAtCell!)
            }
            return cell
        }
        
    }
}

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseId: String = "ttc"
    
    public var image: ImageView = ImageView()
    public var customView: UIHostingController<ImageView>?
    override init(frame: CGRect) {
        super.init(frame: frame)
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
