//
//  CollectionViewProvider.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/26.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class CollectionViewProvider: NSObject {

    var imageDataList = [ImageData]()
}

extension CollectionViewProvider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return imageDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            fatalError("cell is nil")
        }
        
        cell.imageData = imageDataList[indexPath.row]
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = 10
        
        return cell
    }
    
    
}
