//
//  ViewController.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/26.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ImageSourceTransitionType {

    @IBOutlet weak var collectionView: UICollectionView!
    private var imageDataList = [ImageData]()
    private let numberOfColums: CGFloat = 3
    private let spacing: CGFloat = 15
    private var selectedCellIndex = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    private func setup() {
        navigationController?.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        imageDataList = DataSource.create()
    }

    private func itemSize() -> CGSize {
        let insets = self.insets()
        let allSpace = (numberOfColums - 1) * spacing + (insets.left + insets.right)
        let itemLength = (collectionView.bounds.size.width - allSpace) / numberOfColums
        return CGSize(width: itemLength, height: itemLength)
    }

    private func insets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: spacing, bottom: 0, right: spacing)
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDataList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            fatalError("cell is nil")
        }

        cell.setup(imageData: imageDataList[indexPath.row])
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCellIndex = indexPath
        let detailImageVC = DetailImageViewController(imageData: imageDataList[indexPath.item])
        navigationController?.pushViewController(detailImageVC, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets()
    }
}

extension ViewController: UINavigationControllerDelegate {
    
    // 遷移状態進行を管理
//    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        guard let ci = customInteractor else {
//            print("ci is nil")
//            return nil }
//        return ci.transitionInProgress ? customInteractor : nil
//    }

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let detailImageVC = toVC as? ImageDestinationTransitionType else {
            return nil
        }

        switch operation {
        case .push:
//            self.customInteractor = CustomInteractor(attachTo: toVC)
            return ImagePushAnimator(presenting: self, presented: detailImageVC, duration: 1, selectedCellIndex: selectedCellIndex)
        case .pop:
            return ImagePopAnimator(presenting: self, presented: detailImageVC, duration: 1, selectedCellIndex: selectedCellIndex)
        default:
            return nil
        }
    }
}

