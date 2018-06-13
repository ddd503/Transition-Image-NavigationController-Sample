//
//  CustomAnimator.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/06/13.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

final class CustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration : TimeInterval
    var isPresenting : Bool
    var originFrame : CGRect
    var image : UIImage
    
    init(duration : TimeInterval, isPresenting : Bool, originFrame : CGRect, image : UIImage) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.image = image
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    /*
     pushの場合
     遷移先のviewをalphaが0の状態で上に乗せて、遷移元の大きさにアニメーションさせる
     popの場合
     遷移先のviewを遷移元のviewの下に置いて、    遷移元のviewを薄くしながら、遷移先のviewの大きさに寄せていく、完了と同時に消える（imageviewは薄くならない？）
     */
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        /// 遷移情報をインスタンス化
        let container = transitionContext.containerView
        
        /// 遷移元と遷移後の情報からそれぞれ元のViewを取り出す
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        let detailView = isPresenting ? toView : fromView
        
        // 遷移先のimageViewをインスタンス化
        guard
            let destinationVC = isPresenting ? transitionContext.viewController(forKey: .to) as? ImageDestinationTransitionType : transitionContext.viewController(forKey: .from) as? ImageDestinationTransitionType,
            let imageView = destinationVC.imageView else {
                return
        }
        // 遷移先のVCのViewを操作（遷移中に見えないようにする、storyboardでもいい）
        imageView.alpha = 0
        
        let transitionImageView = UIImageView(frame: isPresenting ? originFrame : imageView.frame)
        transitionImageView.image = image
        container.addSubview(transitionImageView)
        
        toView.frame = isPresenting ? CGRect(x: fromView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height) : toView.frame
        
        toView.alpha = isPresenting ? 0 : 1
        
        // viewの再配置(viewの配置を確定させておく)
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            transitionImageView.frame = self.isPresenting ? imageView.frame : self.originFrame
            detailView.frame = self.isPresenting ? fromView.frame : CGRect(x: toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            detailView.alpha = self.isPresenting ? 1 : 0
        }, completion: { (finished) in
            // 遷移が終わったタイミングと遷移カスタムを使用するタイミングを合わせる
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            transitionImageView.removeFromSuperview()
            imageView.alpha = 1
        })
    }
}
