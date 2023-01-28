//
//  PopularCell.swift
//  Movve
//
//  Created by Aleksey Kosov on 21.01.2023.
//

import UIKit

class PopularCell: UICollectionViewCell {

    static let reuseID = "reuseID"

    private let movieLoader = MultimediaLoader()

    let popularImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        iv.image = UIImage(named: "placeholder")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie name"
        label.font = .boldSystemFont(ofSize: 14)
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Dec 16, 1984"
        label.font = .systemFont(ofSize: 12)
        label.heightAnchor.constraint(equalToConstant: 14).isActive = true
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configreLayout()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configreLayout() {
        let stackView = UIStackView(arrangedSubviews: [
            popularImageView,
            titleLabel,
            dateLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .leading
        addSubview(stackView)

        let padding: CGFloat = 0

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding),

            popularImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 190),
            popularImageView.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
    func configureData(multimedia: MultimediaViewModel) {
        titleLabel.text = multimedia.titleName
        dateLabel.text = multimedia.releaseDate
        
        movieLoader.fetchImage(from: multimedia.posterImageLink) { [weak self] image in
            DispatchQueue.main.async {
                self?.popularImageView.image = image
            }
        }
    }

}
