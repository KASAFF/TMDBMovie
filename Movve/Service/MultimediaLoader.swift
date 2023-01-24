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

    static let cache = NSCache<NSString, UIImage>()

    private let baseURL = "https://api.themoviedb.org/3/"
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

    let tvShowGenres: [Int: String] = [
        10759: "Action & Adventure",
        16: "Animation",
        35: "Comedy",
        80: "Crime",
        99: "Documentary",
        18: "Drama",
        10751: "Family",
        10762: "Kids",
        9648: "Mystery",
        10763: "News",
        10764: "Reality",
        10765: "Sci-Fi & Fantasy",
        10766: "Soap",
        10767: "Talk",
        10768: "War & Politics",
        37: "Western"
    ]



    init(delegate: UIViewController? = nil) {
        self.delegate = delegate
    }

    func getAllTypesOfMediaData(completion: @escaping ([[MultimediaViewModel]]) -> Void) {
        var arrayOfAllData = [[MultimediaViewModel]]()
        let group = DispatchGroup()
        MultimediaTypeURL.allCases.forEach { mediaType in
            group.enter()
            getMediaData(for: mediaType) { multiMediaArray in
                arrayOfAllData.append(multiMediaArray)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(arrayOfAllData)
        }
    }
    private func fetchMultimedia(for type: MultimediaTypeURL, completion: @escaping (Multimedia) -> Void) {

        guard let url = URL(string: baseURL + "discover/" + type.rawValue + "?api_key=" + apiKey) else {
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

    func fetchDetailData(multimedia: MultimediaViewModel) {
        guard let url = URL(string: baseURL + "\(multimedia.type.rawValue)/\(multimedia.id)?api_key=\(apiKey)") else { return }
        print(url)

        networkManager.fetchData(with: url) { result in
            switch result {
            case .success(let data):
                do {
                    let multimedia = try self.decoder.decode(DetailMultimediaModel.self, from: data)
                    print(multimedia)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getMediaData(for type: MultimediaTypeURL, completion: @escaping (([MultimediaViewModel]) -> Void)) {
        var multimediaViewModel = [MultimediaViewModel]()

        fetchMultimedia(for: type) { movie in
            guard let result = movie.results else { return }
            result.forEach { movieResult in

                let posterURL = self.imageBaseUrl + movieResult.posterPath
                let formattedDate: String
                let genre: String
                let title: String

                switch type {
                case .movie:
                    formattedDate = movieResult.releaseDate?.convertDateString() ?? "Unknown date"
                    genre = self.movieGenres[movieResult.genreIds.first ?? 00] ?? "Unknown genre"
                    title = movieResult.title ?? "Unknown movie"


                case .tvShow:
                    formattedDate = movieResult.firstAirDate?.convertDateString() ?? "Unknown date"
                    genre = self.tvShowGenres[movieResult.genreIds.first ?? 00] ?? "Unknown genre"
                    title = movieResult.name ?? "Unknown name"
                }

                multimediaViewModel.append(MultimediaViewModel(id: movieResult.id,
                                                               type: type,
                                                               posterImageLink: posterURL,
                                                               titleName: title,
                                                               releaseDate: formattedDate,
                                                               genre: genre,
                                                               description: movieResult.overview,
                                                               rating: movieResult.voteAverage))


            }
            completion(multimediaViewModel)

        }
    }

//    func getMediaDataToShow(completion: @escaping (DetailMultimediaViewModel) -> Void) {
//
//        fetchDetailData(multimedia: )
//    }

    func fetchImage(from endpoint: String, completion: @escaping (UIImage?) -> Void) {
       let cacheKey = NSString(string: endpoint)
        if let image = MultimediaLoader.cache.object(forKey: cacheKey) {
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
                MultimediaLoader.cache.setObject(image, forKey: cacheKey)
                completion(image)
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }
}
