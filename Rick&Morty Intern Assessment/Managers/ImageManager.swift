//
//  ImageManager.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 21.08.2023.
//

import Foundation

final class ImageManager {
    static let shared = ImageManager()
    
    var urlSession: URLSession {
        let configuration = URLSessionConfiguration.default
        
        configuration.urlCache = URLCache(memoryCapacity: 200, diskCapacity: 200, diskPath: "images")
        configuration.timeoutIntervalForRequest = 10
        configuration.httpMaximumConnectionsPerHost = 6
        
        return URLSession(configuration: configuration)
    }
    
    private init() {}
    
    
    /// This method either downloads or retrieves image by provided URL via URLSession data task and stores/retrieves the result in/from the urlSession cache
    /// - Parameters:
    ///   - url: Image URL
    ///   - completion: completion handler in a Result wrapper
    func downloadImage(_ url: URL, completion: @escaping (Result<Data,Error>) -> Void) {
        let request = URLRequest(url: url)
        let task = urlSession.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}
