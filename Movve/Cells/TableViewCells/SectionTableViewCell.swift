//
//  TableViewCell.swift
//  Movve
//
//  Created by Aleksey Kosov on 21.01.2023.
//

import UIKit

protocol CollectionViewCellDelegate: AnyObject {
    func configure(with data: MultimediaViewModel)
}

class SectionsTableViewCell: UITableViewCell {

    weak var delegate: MainViewController?

    var data = [MultimediaViewModel]()

    static let reuseID = "tableId"


    var collectionView: UICollectionView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCollectionView()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createFlowLayout(in: contentView))
        contentView.addSubview(collectionView)
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.reuseID)

        collectionView.backgroundColor = .mainColor

        self.collectionView.delegate = self.delegate
        self.collectionView.dataSource = self.delegate

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
    }
}

