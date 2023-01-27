//
//  CastCell.swift
//  Movve
//
//  Created by Aleksey Kosov on 27.01.2023.
//

import UIKit

class CastCell: UICollectionViewCell {

    static let reuseID = "castCell"

    private let movieLoader = MultimediaLoader()

    var actorImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        iv.image = UIImage(named: "placeholder")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let actorNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Gal Gadot"
        label.font = .boldSystemFont(ofSize: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let characterNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Wonder women"
        label.font = .systemFont(ofSize: 9)
        label.textColor = .systemGray
        label.textAlignment = .center
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

    func configureDataWithActor(playActor: Cast) {
        if let actorImagePath = playActor.profilePath {
            movieLoader.fetchImage(from: actorImagePath, completion: { actorImage in
                self.actorImageView.image = actorImage
            })
        }

        self.actorNameLabel.text = playActor.name
        self.characterNameLabel.text = playActor.character
    }


    private func configreLayout() {
        let stackView = UIStackView(arrangedSubviews: [
            actorImageView,
            actorNameLabel,
            characterNameLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        contentView.addSubview(stackView)

        let padding: CGFloat = 0

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: padding),

            actorImageView.heightAnchor.constraint(equalToConstant: 40),
            actorImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
