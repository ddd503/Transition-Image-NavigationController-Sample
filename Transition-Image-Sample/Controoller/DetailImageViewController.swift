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
    @IBOutlet weak private var closeButton: UIButton!
    private let image: UIImage
    private var statusBarIsHidden = false
    private var currentImageStatus: ImageStatus = .normal

    private enum ImageStatus {
        case normal
        case focus
    }

    init(image: UIImage) {
        self.image = image
        super.init(nibName: "DetailImageViewController", bundle: .main)
        // xibだとiPhoneX画面サイズ = view.frameとはならないため
        view.frame.size.height = UIScreen.main.bounds.height
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var prefersStatusBarHidden: Bool {
        return statusBarIsHidden
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !closeButton.isEnabled {
            UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveLinear, animations: {
                self.closeButton.alpha = 1.0
            }) { (_) in
                self.closeButton.isEnabled = true
            }
        }
    }

    @IBAction func didTapScreen(_ sender: UITapGestureRecognizer) {
        setImageStatus(currentImageStatus)
    }

    @IBAction func didTapClose(_ sender: UIButton) {
        sender.isHidden = true
        dismiss(animated: true, completion: nil)
    }

    private func setImageStatus(_ status: ImageStatus) {
        switch status {
        case .normal:
            closeButton.isHidden = true
            view.backgroundColor = .black
            statusBarIsHidden = true
            currentImageStatus = .focus
        case .focus:
            closeButton.isHidden = false
            view.backgroundColor = .white
            statusBarIsHidden = false
            currentImageStatus = .normal
        }
        setNeedsStatusBarAppearanceUpdate()
    }

}
