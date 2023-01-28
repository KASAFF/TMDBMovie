//
//  BookmarksViewController.swift
//  Movve
//
//  Created by Aleksey Kosov on 28.01.2023.


import UIKit

class BookmarksViewController: UIViewController {

    let headerLabel: UILabel = {
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "FAVO", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25.0)])

        navTitle.append(NSMutableAttributedString(string: "RITES", attributes:[
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24.0),
            NSAttributedString.Key.foregroundColor: UIColor.red]))
        navLabel.attributedText = navTitle
        navLabel.translatesAutoresizingMaskIntoConstraints = false

        return navLabel
    }()

    let searchDummyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createFlowLayoutBookmarks(in: view))
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainColor
        configureCollectionView()
        setLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTabBarHidden(false)
        navigationController?.navigationBar.isHidden = true
        collectionView.reloadData()
    }

    // MARK: - Table view data source
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }


    func setLayout() {
        let topStackView = UIStackView(arrangedSubviews: [
            headerLabel, searchDummyButton
        ])
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.axis = .horizontal
        topStackView.distribution = .equalSpacing
        view.addSubview(topStackView)

        view.addSubview(collectionView)

        let padding: CGFloat = 8

        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            topStackView.heightAnchor.constraint(equalToConstant: 50),

            collectionView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }


    func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.reuseID)

        collectionView.backgroundColor = .mainColor

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false

        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
}

extension BookmarksViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let multimedia = MultimediaLoader.shared.bookmarks[indexPath.item]

        let detailVC = DetailMediaViewController(multimedia: multimedia)

        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension BookmarksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(MultimediaLoader.shared.bookmarks.count)
        return MultimediaLoader.shared.bookmarks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseID, for: indexPath) as! PopularCell
        let multimedia = MultimediaLoader.shared.bookmarks[indexPath.item]
        cell.configureData(multimedia: multimedia)

        return cell
    }
}
