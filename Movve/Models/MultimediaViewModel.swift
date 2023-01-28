//
//  MultimediaViewModel.swift
//  Movve
//
//  Created by Aleksey Kosov on 22.01.2023.
//

import UIKit

struct MultimediaViewModel: Hashable {
    let id: Int
    let type: MultimediaTypeURL
    let posterImageLink: String
    let titleName: String
    let releaseDate: String
    let genre: String?
    let description: String
    let rating: Double
}
