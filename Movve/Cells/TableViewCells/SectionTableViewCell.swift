//
//  TableViewCell.swift
//  Movve
//
//  Created by Aleksey Kosov on 21.01.2023.
//

import UIKit

class SectionsTableViewCell: UITableViewCell {

    static let reuseID = "tableId"

    private var collectionView: UICollectionView!

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

        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
    }

}

extension SectionsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseID, for: indexPath) as! PopularCell
        return cell
    }


}

extension SectionsTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {


}

