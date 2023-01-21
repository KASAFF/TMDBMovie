//
//  ViewController.swift
//  Movve
//
//  Created by Aleksey Kosov on 21.01.2023.
//

import UIKit

class MainViewController: UIViewController {

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

    lazy var multimediaLoader  = MultimediaLoader(delegate: self)

    var collectionView: UICollectionView!

    var multimedias = [Multimedia]()

    override func viewDidLoad() {
        super.viewDidLoad()

        multimediaLoader.fetchMultimedia(for: .movie) { movie in
            self.multimediaLoader.fetchImage(from: (movie.results?[0].posterPath)!) { image in
                
            }
        }



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

//MARK: - TableView

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SectionsTableViewCell.reuseID, for: indexPath) as! SectionsTableViewCell
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }


}

extension MainViewController: UITableViewDelegate {

}

//MARK: - Collection View




