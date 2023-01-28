//
//  MainTabBarController.swift
//  Movve
//
//  Created by Aleksey Kosov on 21.01.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    var alertPresenter: AlertPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarApperance()
        alertPresenter = AlertPresenter(delegate: self)
        
        if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = .mainColor
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
            }

        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            navigationBarAppearance.backgroundColor = .mainColor
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }

    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: UINavigationController(rootViewController: MainViewController()), title: "Home", image: UIImage(systemName: "house.fill")),
            generateVC(viewController: UIViewController(), title: "Play", image: UIImage(systemName: "play.circle")),
            generateVC(viewController: UINavigationController(rootViewController: BookmarksViewController()), title: "Bookmarks", image: UIImage(systemName: "bookmark")),
            generateVC(viewController: UIViewController(), title: "Profile", image: UIImage(systemName: "person"))
        ]
    }

    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }

    private func setTabBarApperance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2

        let roundLayer = CAShapeLayer()

        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: positionOnX,
                                y: tabBar.bounds.minY - positionOnY,
                                width: width,
                                height: height
                               ),
            cornerRadius: height / 2
        )

        roundLayer.path = bezierPath.cgPath

        tabBar.layer.insertSublayer(roundLayer, at: 0)

        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered

        roundLayer.fillColor = UIColor.tabBarColor.cgColor

        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarUnselectedColor
    }

    func showNetworkError(message: String) {

        let errorAlert = AlertModel(title: "Ошибка",
                                    message: message,
                                    buttonText: "Попробовать еще раз") { [weak self] in
           // guard let self = self else { return }
        }

        alertPresenter?.show(model: errorAlert)
    }
}
