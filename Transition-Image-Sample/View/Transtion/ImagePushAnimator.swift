//
//  ImagePushAnimator.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2019/06/02.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class ImagePushAnimator: NSObject {
    weak var presenting: ImageSourceTransitionType?
    weak var presented: ImageDestinationTransitionType?
    let duration: TimeInterval
    let selectedCellIndex: IndexPath

    init(presenting: ImageSourceTransitionType, presented: ImageDestinationTransitionType, duration: TimeInterval, selectedCellIndex: IndexPath) {
        self.presenting = presenting
        self.presented = presented
        self.duration = duration
        self.selectedCellIndex = selectedCellIndex
    }
}

extension ImagePushAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presenting = presenting, let presented = presented else {
            transitionContext.cancelInteractiveTransition()
            return
        }

        let containerView = transitionContext.containerView
        presented.view.frame = transitionContext.finalFrame(for: presented)
        containerView.addSubview(presented.view)
        presented.view.layoutIfNeeded()
        presented.view.alpha = 0

        guard let transitionableCell = presenting.collectionView.cellForItem(at: selectedCellIndex) as? CollectionViewCell else {
            transitionContext.cancelInteractiveTransition()
            return
        }

        let animationView = UIView(frame: presented.view.frame)
        animationView.backgroundColor = .white
        let imageView = UIImageView(frame: transitionableCell.imageView.superview!.convert(transitionableCell.imageView.frame, to: animationView))
        imageView.image = transitionableCell.imageView.image
        imageView.contentMode = transitionableCell.imageView.contentMode
        animationView.addSubview(imageView)
        containerView.addSubview(animationView)

        let animation = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.8) {
            imageView.frame = presented.imageView.frame
        }
        animation.addCompletion { (_) in
            presented.view.alpha = 1
            animationView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        animation.startAnimation()
    }
}
