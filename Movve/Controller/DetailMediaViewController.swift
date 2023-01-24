//
//  DetailMediaViewController.swift
//  Movve
//
//  Created by Aleksey Kosov on 23.01.2023.
//

import UIKit

class DetailMediaViewController: UIViewController {

    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "test")
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test Name"
        label.font = .boldSystemFont(ofSize: 36)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test Cinema Name"
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()

    var starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach { _ in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            arrangedSubviews.append(imageView)
        }
        arrangedSubviews.append(UIView())


        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let overviewTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .mainColor
        tv.font = .preferredFont(forTextStyle: .body)
        tv.textColor = .systemGray
        tv.isScrollEnabled = false
        tv.text = "Long text Long text Long text Long text Long text Long text Long text Long text Long text Long text Long text Long text"
        return tv
    }()

    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    var multimedia: DetailMultimediaModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        view.backgroundColor = .mainColor

        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func configureViewWithData() {
        titleLabel.text = multimedia.title
        
    }

    let gradient = CAGradientLayer()


    private func addFadingLayer(in fadableView: UIView) {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: fadableView.frame.width, height: 100)
        let startColor = UIColor.clear.cgColor
        let endColor = UIColor.mainColor.cgColor
        gradient.colors = [startColor, endColor]
        gradient.locations = [0, 1]

        view.addSubview(fadableView)
        fadableView.layer.addSublayer(gradient)
    }

    private func setupLayout() {
        let fadingView = UIView(frame: CGRect(x: 0, y: 322, width: view.frame.width, height: 50))
        fadingView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)

        view.addSubview(scrollView)
        scrollView.addSubview(posterImageView)

        addFadingLayer(in: fadingView)

        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        view.addSubview(starsStackView)
        view.addSubview(overviewTextView)


        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

            posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),

            fadingView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -100),
            fadingView.heightAnchor.constraint(equalToConstant: 100),
            fadingView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            titleLabel.bottomAnchor.constraint(equalTo: fadingView.bottomAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            titleLabel.heightAnchor.constraint(equalToConstant: 44),

            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            infoLabel.heightAnchor.constraint(equalToConstant: 20),

            starsStackView.topAnchor.constraint(equalTo: infoLabel.topAnchor, constant: 25),
            starsStackView.heightAnchor.constraint(equalToConstant: 24),
            starsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            starsStackView.widthAnchor.constraint(equalToConstant: 140),

            overviewTextView.topAnchor.constraint(equalTo: starsStackView.bottomAnchor, constant: 10),
            overviewTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            overviewTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            overviewTextView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

}

extension DetailMediaViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
               scrollView.contentOffset.y = 0
           }
    }

}

/*
func setupLayout() {

    let backgroundView = UIView(frame: CGRect(x: 0, y: 322, width: view.frame.width, height: 50))

    backgroundView.translatesAutoresizingMaskIntoConstraints = false

    let scrollView = UIScrollView(frame: view.frame)

    scrollView.addSubview(posterImageView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)

    view.addSubview(scrollView)
    scrollView.addSubview(posterImageView)

    let gradient = CAGradientLayer()
    gradient.frame = CGRect(x: 0, y: 322, width: view.frame.width, height: 50)
    let startColor = UIColor.clear.cgColor
    let endColor = UIColor.mainColor.cgColor
    gradient.colors = [startColor, endColor]
    gradient.locations = [0, 1]


    view.addSubview(backgroundView)


    posterImageView.layer.addSublayer(gradient)




    NSLayoutConstraint.activate([
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

        posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
        posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        posterImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),

//            backgroundView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -50),
//            backgroundView.heightAnchor.constraint(equalToConstant: 100),
//            backgroundView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])
}

}
*/