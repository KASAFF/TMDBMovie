//
//  Multimedia.swift
//  Movve
//
//  Created by Aleksey Kosov on 21.01.2023.
//

import Foundation

// MARK: - Multimedia
struct Multimedia: Codable {
    let page: Int
    let results: [Result]?
    enum CodingKeys: String, CodingKey {
        case page, results
    }
}

// MARK: - Result
struct Result: Codable {
    let genreIds: [Int]
    let id: Int
    let overview: String
    let posterPath, releaseDate, title: String
    let voteAverage: Double
}
