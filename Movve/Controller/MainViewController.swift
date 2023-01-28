//
//  ViewController.swift
//  Movve
//
//  Created by Aleksey Kosov on 21.01.2023.
//

import UIKit

class MainViewController: DataLoadingVC {

    let headerLabel: UILabel = {
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "KASS", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25.0)])

        navTitle.append(NSMutableAttributedString(string: "AFF", attributes:[
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

    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SectionsTableViewCell.self, forCellReuseIdentifier: SectionsTableViewCell.reuseID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var alertPresenter: AlertPresenterProtocol!
    lazy var multimediaLoader = MultimediaLoader(delegate: self)

    var collectionView: UICollectionView!

    var allDataArray = [[MultimediaViewModel]]() {
        didSet {
            tableView.reloadData()
            if allDataArray.count == MultimediaTypeURL.allCases.count {
                moviesArray = allDataArray[0]
                tvShowsArray = allDataArray[1]
            }
        }
    }

    var moviesArray = [MultimediaViewModel]()

    var tvShowsArray = [MultimediaViewModel]()

    func fetchAllTypesOfMedia() {
        multimediaLoader.getAllTypesOfMediaData { allDataArray in
            self.allDataArray = allDataArray
            self.dismissLoadingView()
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        alertPresenter = AlertPresenter(delegate: self)

        fetchAllTypesOfMedia()

        view.backgroundColor = .mainColor
        view.addSubview(tableView)
        setLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .mainColor
        tableView.separatorStyle = .none

        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        if let tabbar = tabBarController?.tabBar, tabbar.isHidden {
            setTabBarHidden(false)
        }
    }

    private func setLayout() {
        let topStackView = UIStackView(arrangedSubviews: [
            headerLabel, searchDummyButton
        ])
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.axis = .horizontal
        topStackView.distribution = .equalSpacing

        let overallStackView = UIStackView(arrangedSubviews: [
            topStackView,
            tableView
        ])
        overallStackView.axis = .vertical
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.spacing = 8
        view.addSubview(overallStackView)

        NSLayoutConstraint.activate([
            overallStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            overallStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            overallStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            overallStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }




    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerLabel = UILabel()
        headerLabel.font = .preferredFont(forTextStyle: .headline)
        headerLabel.textColor = .white

        switch section {
        case 0:
            headerLabel.text = "Popular Movie"
        default: headerLabel.text = "TV Shows"
        }

        return headerLabel
    }
}

var currentData = [MultimediaViewModel]()
//MARK: - TableView

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return allDataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SectionsTableViewCell.reuseID) as! SectionsTableViewCell
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self

        cell.collectionView.tag = indexPath.section

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }


}

extension MainViewController: UITableViewDelegate {

}

//MARK: - Collection View

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0: return moviesArray.count
        case 1: return tvShowsArray.count
        default: break
        }
        return 1
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseID, for: indexPath) as! PopularCell
        let multimediaType = collectionView.tag == 0 ? moviesArray : tvShowsArray
        let multimedia = multimediaType[indexPath.row]

        cell.configureData(multimedia: multimedia)
        

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let multimediaType = collectionView.tag == 0 ? moviesArray : tvShowsArray
        let multimedia = multimediaType[indexPath.row]

        let detailVC = DetailMediaViewController(multimedia: multimedia)


        navigationController?.pushViewController(detailVC, animated: true)
    }
}


