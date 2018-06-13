//
//  CollectionViewCell.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/26.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell, ImageDestinationTransitionType {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }

    var imageData: ImageData? {
        didSet {
            self.imageView.image = imageData?.image
            self.label.text = imageData?.imageName
        }
    }
}
