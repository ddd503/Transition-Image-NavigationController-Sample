//
//  DataSource.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/26.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

final class DataSource {
    static func create() -> [ImageData] {
        guard let filePath = Bundle.main.path(forResource: "image_list", ofType: "json") else {
            fatalError("not found ImageList")
        }

        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
            let mapResponse = try JSONDecoder().decode(Images.self, from: jsonData)
            return mapResponse.images
        } catch {
            fatalError("did fail get ImageList")
        }
    }
}
