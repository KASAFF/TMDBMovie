//
//  UIHelper.swift
//  Movve
//
//  Created by Aleksey Kosov on 21.01.2023.
//

import UIKit

enum UIHelper {

    static func createFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let flow = UICollectionViewFlowLayout()

        // Define layout constants
        let itemSpacing: CGFloat = 16
        let minimumCellWidth: CGFloat = 140
        let collectionViewWidth = view.bounds.size.width

        // Calculate other required constants
        let itemsInOneLine = CGFloat(Int((collectionViewWidth - CGFloat(Int(collectionViewWidth / minimumCellWidth) - 1) * itemSpacing) / minimumCellWidth))
        let width = collectionViewWidth - itemSpacing * (itemsInOneLine - 1)
        let cellWidth = floor(width / itemsInOneLine)
        let realItemSpacing = itemSpacing + (width / itemsInOneLine - cellWidth) * itemsInOneLine / max(1, itemsInOneLine - 1)

        // Apply values
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        flow.itemSize = CGSize(width: cellWidth, height: cellWidth + 80)
        flow.minimumInteritemSpacing = realItemSpacing
        flow.minimumLineSpacing = realItemSpacing
        flow.scrollDirection = .horizontal

        return flow
    }

    static func createFlowLayoutBookmarks(in view: UIView) -> UICollectionViewFlowLayout {
        let flow = UICollectionViewFlowLayout()

        // Define layout constants
        let itemSpacing: CGFloat = 16
        let minimumCellWidth: CGFloat = 140
        let collectionViewWidth = view.bounds.size.width

        // Calculate other required constants
        let itemsInOneLine = CGFloat(Int((collectionViewWidth - CGFloat(Int(collectionViewWidth / minimumCellWidth) - 1) * itemSpacing) / minimumCellWidth))
        let width = collectionViewWidth - itemSpacing * (itemsInOneLine - 1)
        let cellWidth = floor(width / itemsInOneLine)
        let realItemSpacing = itemSpacing + (width / itemsInOneLine - cellWidth) * itemsInOneLine / max(1, itemsInOneLine - 1)

        // Apply values
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        flow.itemSize = CGSize(width: cellWidth - 30, height: cellWidth + 80)
        flow.minimumInteritemSpacing = realItemSpacing
        flow.minimumLineSpacing = realItemSpacing
        flow.scrollDirection = .horizontal

        return flow
    }

    static func createFlowLayoutCast(in view: UIView) -> UICollectionViewFlowLayout {
        let flow = UICollectionViewFlowLayout()

        // Define layout constants
        let itemSpacing: CGFloat = 16
        let minimumCellWidth: CGFloat = 40
        let collectionViewWidth = view.bounds.size.width

        // Calculate other required constants
        let itemsInOneLine = CGFloat(Int((collectionViewWidth - CGFloat(Int(collectionViewWidth / minimumCellWidth) - 1) * itemSpacing) / minimumCellWidth))
        let width = collectionViewWidth - itemSpacing * (itemsInOneLine - 1)
        let cellWidth = floor(width / itemsInOneLine)
        let realItemSpacing = itemSpacing + (width / itemsInOneLine - cellWidth) * itemsInOneLine / max(1, itemsInOneLine - 1)

        // Apply values
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        flow.itemSize = CGSize(width: cellWidth + 20, height: cellWidth + 20)
        flow.minimumInteritemSpacing = realItemSpacing
        flow.minimumLineSpacing = realItemSpacing
        flow.scrollDirection = .horizontal

        return flow
    }
}



extension UIViewController {

    func setTabBarHidden(_ hidden: Bool, animated: Bool = true, duration: TimeInterval = 0.4) {
        if self.tabBarController?.tabBar.isHidden != hidden{
            if animated {
                //Show the tabbar before the animation in case it has to appear
                if (self.tabBarController?.tabBar.isHidden)!{
                    self.tabBarController?.tabBar.isHidden = hidden
                }
                if let frame = self.tabBarController?.tabBar.frame {
                    let factor: CGFloat = hidden ? 1.1 : -1.1
                    let y = frame.origin.y + (frame.size.height * factor)
                    UIView.animate(withDuration: duration, animations: {
                        self.tabBarController?.tabBar.frame = CGRect(x: frame.origin.x, y: y, width: frame.width, height: frame.height)
                    }) { (bool) in
                        //hide the tabbar after the animation in case ti has to be hidden
                        if (!(self.tabBarController?.tabBar.isHidden)!){
                            self.tabBarController?.tabBar.isHidden = hidden
                        }
                    }
                }
            }
        }
    }

}
