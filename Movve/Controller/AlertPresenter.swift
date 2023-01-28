//
//  AlertPresenter.swift
//  Movve
//
//  Created by Aleksey Kosov on 28.01.2023.
//

import UIKit

protocol AlertPresenterProtocol {
    func show(model: AlertModel)
}

 struct AlertPresenter: AlertPresenterProtocol {

   private weak var delegate: UIViewController?

    func show(model: AlertModel) {
        let alert = UIAlertController(title: model.title, // заголовок всплывающего окна
                                      message: model.message, // текст во всплывающем окне
                                      preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "Game results"

        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion()
        }

        alert.addAction(action)
        showAlert(alert)
    }

     init(delegate: UIViewController?) {
         self.delegate = delegate
     }

   private func showAlert(_ alert: UIAlertController) {
        delegate?.present(alert, animated: true)
    }

}
