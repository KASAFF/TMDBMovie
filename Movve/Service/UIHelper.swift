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
}
