//
//  ViewController.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/26.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let provider = CollectionViewProvider()
    private var customInteractor : CustomInteractor?
    private var selectedImageFrame: CGRect?
    private var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup() {
        self.navigationController?.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = provider
        provider.imageDataList = DataSource.create()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cellLayout = collectionView.layoutAttributesForItem(at: indexPath) else {
            print("selected cell is nil")
            return
        }
        // 遷移中のviewで使用する
        self.selectedImageFrame = collectionView.convert(cellLayout.frame, to: collectionView.superview)
        
        guard let image = self.provider.imageDataList[indexPath.row].image else {
            print("image is nil")
            return
        }
        
        // 遷移中のviewで使用する
        self.selectedImage = image
    
        self.navigationController?.pushViewController(ImageViewController.make(image: image), animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    // アイテムの大きさを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = self.view.frame.width / 3.5
        
        return CGSize(width: size, height: size)
    }
    
    // コレクションビュー自体の周りのinset（セル同士のinsetはstoryboardで）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let inset: CGFloat =  self.view.frame.width / 24
        
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
}

// MARK: - UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
    
    // 遷移状態進行を管理
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let ci = customInteractor else {
            print("ci is nil")
            return nil }
        return ci.transitionInProgress ? customInteractor : nil
    }
    
    // 遷移をカスタムを適用する
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let frame = self.selectedImageFrame else { return nil }
        
        // 遷移中のviewへも要素を受け渡す
        guard let image = self.selectedImage else { return nil }
        
        switch operation {
        case .push:
            self.customInteractor = CustomInteractor(attachTo: toVC)
            return CustomAnimator(duration: TimeInterval(UINavigationControllerHideShowBarDuration),
                                  isPresenting: true,
                                  originFrame: frame,
                                  image: image)
        case .pop:
            return CustomAnimator(duration: TimeInterval(UINavigationControllerHideShowBarDuration),
                                  isPresenting: false,
                                  originFrame: frame,
                                  image: image)
        default:
            return nil
        }
    }
}

