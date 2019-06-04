//
//  ImageTransitionProtocol.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/27.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

protocol ImageSourceTransitionType: UIViewController {
    var view: UIView! { get }
    var collectionView: UICollectionView! { get }
}

protocol ImageDestinationTransitionType: UIViewController {
    var view: UIView! { get }
    var imageView: UIImageView! { get }
}
