//
//  ImageViewController.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/27.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, ImageDestinationTransitionType {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    static var identifer: String {
        return String(describing: self)
    }
    
    var image: UIImage?

    // MARK: - Factory
    class func make(image: UIImage) -> ImageViewController {
        let storyboard = UIStoryboard(name: "Image", bundle: nil)
        guard let imageViewControllerVC = storyboard.instantiateViewController(withIdentifier: ImageViewController.identifer) as? ImageViewController else {
            fatalError("VCのインスタンス化に失敗")
        }
        
        imageViewControllerVC.image = image
        return imageViewControllerVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = self.image
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // ボタンもアニメーションで出す
        if !self.backButton.isEnabled {
            UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveLinear, animations: {
                self.backButton.alpha = 1.0
            }) { (_) in
                self.backButton.isEnabled = true
            }
        }
    }
    
    // 戻る
    @IBAction func back(_ sender: UIButton) {
        sender.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }
}
