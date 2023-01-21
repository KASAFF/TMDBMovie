//
//  MultimediaLoader.swift
//  Movve
//
//  Created by Aleksey Kosov on 22.01.2023.
//

import UIKit

final class MultimediaLoader {

    weak var delegate: UIViewController?

    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    private let networkManager = NetworkManager()

    let cache = NSCache<NSString, UIImage>()

    private let baseURL = "https://api.themoviedb.org/3/discover/"
    private let apiKey = "594bcc6cf3865f6c3e8326fd2d8f3f17"

    private let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"

    enum MultimediaTypeURL: String {
        case movie = "movie"
        case tvShow = "tv"
    }

    init(delegate: UIViewController?) {
        self.delegate = delegate
    }

//    func convertMultimediaToViewModel(multimedia: Multimedia) -> MultimediaViewModel {
////        MultimediaViewModel(
////            posterImage: <#T##UIImage#>,
////            titleName: <#T##String#>,
////            releaseDate: <#T##String#>,
////            genre: <#T##String?#>,
////            description: <#T##String#>,
////            rating: <#T##Double#>)
//    }

    func fetchMultimedia(for type: MultimediaTypeURL, completion: @escaping (Multimedia) -> Void) {

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

                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func fetchImage(from endpoint: String, completion: @escaping (UIImage?) -> Void) {
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
                print(error)
            }
        }
    }
}
