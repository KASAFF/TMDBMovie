//
//  MovveError.swift
//  Movve
//
//  Created by Aleksey Kosov on 28.01.2023.
//

import Foundation

enum MovveeError: String, Error {
    case codeError = "Проиозшла ошибка при обработке запроса. Повторите позднее"
    case errorLoadingImage = "Произошла ошибка при загрузке изображения. Повторите попытку позднее"
    case errorInvalidResponse = "Произошла ошибка при загрузке данных. Попробуйте позднее."
}
