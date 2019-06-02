//
//  DetailImageViewController.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2019/06/02.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class DetailImageViewController: UIViewController, ImageDestinationTransitionType {

    @IBOutlet weak var imageView: UIImageView!
    private var statusBarIsHidden = false
    private var currentImageStatus: ImageStatus = .normal

    private enum ImageStatus {
        case normal
        case focus
    }

    init(imageData: ImageData) {
        super.init(nibName: "DetailImageViewController", bundle: .main)
        // xibだとiPhoneX画面サイズ = view.frameとはならないため
        view.frame.size.height = UIScreen.main.bounds.height
        title = imageData.title
        imageView.image = UIImage(named: imageData.name)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var prefersStatusBarHidden: Bool {
        return statusBarIsHidden
    }

    @IBAction func didTapScreen(_ sender: UITapGestureRecognizer) {
        setImageStatus(currentImageStatus)
    }

    private func setImageStatus(_ status: ImageStatus) {
        switch status {
        case .normal:
            view.backgroundColor = .black
            statusBarIsHidden = true
            currentImageStatus = .focus
        case .focus:
            view.backgroundColor = .white
            statusBarIsHidden = false
            currentImageStatus = .normal
        }
        setNeedsStatusBarAppearanceUpdate()
    }

}
