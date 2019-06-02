//
//  ImageData.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/26.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import Foundation

struct Images: Decodable {
    let images: [ImageData]
}

struct ImageData: Decodable {
    let name: String
    let title: String
}
