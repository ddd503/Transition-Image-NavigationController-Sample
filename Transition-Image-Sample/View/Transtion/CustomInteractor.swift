//
//  CustomInteractor.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/06/13.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class CustomInteractor: UIPercentDrivenInteractiveTransition {
    weak var navigationController: UINavigationController!
    weak var presentedViewController: UIViewController!
    var interactionInProgress = false
    private var shouldCompleteTransition = false
    
    init(navigationController: UINavigationController, presentedViewController: UIViewController) {
        self.navigationController = navigationController
        self.presentedViewController = presentedViewController
        super.init()
        setupBackGesture(view: self.presentedViewController.view)
    }

    // 戻るGesture生成
    private func setupBackGesture(view : UIView) {
        let swipeBackGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleBackGesture(_:)))
        swipeBackGesture.edges = .left
        view.addGestureRecognizer(swipeBackGesture)
    }

    @objc private func handleBackGesture(_ gesture : UIScreenEdgePanGestureRecognizer) {
        let viewTranslation = gesture.translation(in: presentedViewController.view)
        let progress = viewTranslation.x / presentedViewController.view.frame.width

        switch gesture.state {
        case .began:
            interactionInProgress = true
            navigationController.popViewController(animated: true)
        case .changed:
            // 中心以上スワイプしたら
            shouldCompleteTransition = progress > 0.5
            update(progress)
        case .cancelled:
            interactionInProgress = false
            cancel()
        case .ended:
            interactionInProgress = false
            shouldCompleteTransition ? finish() : cancel()
        default: break
        }
    }
}

//class CustomInteractor: UIPercentDrivenInteractiveTransition {
//
//    var navigationController : UINavigationController
//    var shouldCompleteTransition = false
//    var transitionInProgress = false
//
//    init?(attachTo viewController : UIViewController) {
//        if let nav = viewController.navigationController {
//            self.navigationController = nav
//            super.init()
//            setupBackGesture(view: viewController.view)
//        } else {
//            return nil
//        }
//    }
//
//    private func setupBackGesture(view : UIView) {
//        let swipeBackGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleBackGesture(_:)))
//        swipeBackGesture.edges = .left
//        view.addGestureRecognizer(swipeBackGesture)
//    }
//
//    @objc private func handleBackGesture(_ gesture : UIScreenEdgePanGestureRecognizer) {
//
//        let viewTranslation = gesture.translation(in: gesture.view?.superview)
//        let progress = viewTranslation.x / self.navigationController.view.frame.width
//
//        switch gesture.state {
//        case .began:
//            transitionInProgress = true
//            navigationController.popViewController(animated: true)
//        case .changed:
//            // 中心以上スワイプしたら
//            shouldCompleteTransition = progress > 0.5
//            update(progress)
//        case .cancelled:
//            transitionInProgress = false
//            cancel()
//        case .ended:
//            transitionInProgress = false
//            shouldCompleteTransition ? finish() : update(0)
//        default: break
//        }
//    }
//
//}
