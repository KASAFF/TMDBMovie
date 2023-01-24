//
//  DetailMultimediaViewModel.swift
//  Movve
//
//  Created by Aleksey Kosov on 24.01.2023.
//

import Foundation

struct DetailMultimediaViewModel: Codable {
    let genres: String
    let id: Int
    let overview: String
    let releaseYear: String
    let title: String
    let posterPath: String
    let voteAverage: Double
    let runtime: Int?
}

// MARK: - Result

