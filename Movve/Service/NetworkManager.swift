//
//  NetworkManager.swift
//  Movve
//
//  Created by Aleksey Kosov on 21.01.2023.
//

import Foundation

final class NetworkManager {

    
    func fetchData(with url: URL, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let response = response as? HTTPURLResponse,
                response.statusCode < 200 || response.statusCode >= 300 {
               // completion(.failure(error.unsafelyUnwrapped) )
                return
            }

            guard let data = data else { return }
            completion(.success(data))
        }
        task.resume()
    }
}



//do {
//    let decoder = JSONDecoder()
//    decoder.keyDecodingStrategy = .convertFromSnakeCase
//  let multimedia = try decoder.decode(Multimedia.self, from: data)
//    print(multimedia.results?.first)
//} catch {
//    print(error)
//}

 // guard let url = URL(string: baseURL + contentType.rawValue + "?api_key=" + apiKey) else { return }


// https://api.themoviedb.org/3/discover/movie?api_key=594bcc6cf3865f6c3e8326fd2d8f3f17 movie link
// https://api.themoviedb.org/3/discover/movie?api_key594bcc6cf3865f6c3e8326fd2d8f3f17

// https://api.themoviedb.org/3/discover/tv?api_key=594bcc6cf3865f6c3e8326fd2d8f3f17

// https://image.tmdb.org/t/p/w500/ imagepath

// https://api.themoviedb.org/3/movie/315162?api_key=594bcc6cf3865f6c3e8326fd2d8f3f17 detail VC
