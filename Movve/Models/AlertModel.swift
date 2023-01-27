//
//  AlertModel.swift
//  Movve
//
//  Created by Aleksey Kosov on 28.01.2023.
//

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: (()->())
}
