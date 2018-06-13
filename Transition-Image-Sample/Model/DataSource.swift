//
//  DataSource.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/26.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

final class DataSource: NSObject {
    
    static func create() -> [ImageData] {
        
        var result = [ImageData]()
        
        guard
            let filePath =  Bundle.main.path(forResource: "ImageList", ofType: "plist"),
            let contentsOfFile = NSDictionary(contentsOfFile: filePath),
            let imageList = contentsOfFile.object(forKey: "Images") as? NSArray
            else {
                return result
        }
        
        // dicを配列に入れた上でArrayメソッドのforEachで処理
        imageList.forEach {
            
            guard let dic = $0 as? NSDictionary else {
                return
            }
            
            var imageData = ImageData.init(image: nil, imageName: nil)
            
            imageData.image = UIImage(named: dic["image"] as? String ?? "")
            imageData.imageName = dic["imageName"] as? String ?? ""
            
            result.append(imageData)
            
        }
        return result
    }
}
