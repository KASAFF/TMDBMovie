//
//  MultimediaLoader.swift
//  Movve
//
//  Created by Aleksey Kosov on 22.01.2023.
//

import UIKit


protocol MultimediaLoaderProtocol: AnyObject {
    func getMediaData(for type: MultimediaTypeURL, completion: @escaping (([MultimediaViewModel]) -> Void))
}

enum MultimediaTypeURL: String, CaseIterable {
    case movie = "movie"
    case tvShow = "tv"
}

final class MultimediaLoader {

    weak var delegate: UIViewController?

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    private let networkManager = NetworkManager()

    let cache = NSCache<NSString, UIImage>()

    private let baseURL = "https://api.themoviedb.org/3/discover/"
    private let apiKey = "594bcc6cf3865f6c3e8326fd2d8f3f17"

    private let imageBaseUrl = "https://image.tmdb.org/t/p/w500"



    private let movieGenres: [Int: String] = [
         28: "Action",
         12: "Adventure",
         16: "Animation",
         35: "Comedy",
         80: "Crime",
         99: "Documentary",
         18: "Drama",
         10751: "Family",
         14: "Fantasy",
         36: "History",
         27: "Horror",
         10402: "Music",
         9648: "Mystery",
         10749: "Romance",
         878: "Science Fiction",
         10770: "TV Movie",
         53: "Thriller",
         10752: "War",
         37: "Western",

         00: "No data"
     ]


    init(delegate: UIViewController?) {
        self.delegate = delegate
    }

    func getMediaData(for type: MultimediaTypeURL, completion: @escaping (([MultimediaViewModel]) -> Void)) {
        var multimediaViewModel = [MultimediaViewModel]()

        fetchMultimedia(for: type) { movie in
            guard let result = movie.results else { return }
            result.forEach { movieResult in

                let posterURL = self.imageBaseUrl + movieResult.posterPath


                switch type {
                case .movie:
                    let formattedDate = movieResult.releaseDate?.convertDateString()
                    let genre = self.movieGenres[movieResult.genreIds.first ?? 00]

                    multimediaViewModel.append(MultimediaViewModel(posterImageLink: posterURL,
                                                                   titleName: movieResult.title ?? "Unknown movie",
                                                                   releaseDate: formattedDate ?? "No date",
                                                                   genre: genre,
                                                                   description: movieResult.overview,
                                                                   rating: movieResult.voteAverage))
                case .tvShow:
                    return
                }


            }
            completion(multimediaViewModel)

        }
    }

    func getAllTypesOfMediaData(completion: @escaping (([MultimediaViewModel]) -> Void)) {
        print(MultimediaTypeURL.allCases)
        MultimediaTypeURL.allCases.forEach { mediaType in
            print(mediaType)
            getMediaData(for: mediaType) { multiMediaArray in
                completion(multiMediaArray)
            }
        }
    }

   private func fetchMultimedia(for type: MultimediaTypeURL, completion: @escaping (Multimedia) -> Void) {

        guard let url = URL(string: baseURL + type.rawValue + "?api_key=" + apiKey) else {
            return
        }

        networkManager.fetchData(with: url) { result in
            switch result {
            case .success(let data):
                do {
                    let multimedia = try self.decoder.decode(Multimedia.self, from: data)
                    completion(multimedia)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

   private func fetchImage(from endpoint: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: endpoint)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }

        guard let url = URL(string: imageBaseUrl + endpoint) else { return }
        networkManager.fetchData(with: url) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                completion(image)
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }
}
