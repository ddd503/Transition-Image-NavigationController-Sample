//
//  CollectionViewCell.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/26.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell, TransitionableCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak private var label: UILabel!

    static var identifier: String {
        return String(describing: self)
    }

    func setup(imageData: ImageData) {
        imageView.image = UIImage(named: imageData.name)
        label.text = imageData.title
    }

}
