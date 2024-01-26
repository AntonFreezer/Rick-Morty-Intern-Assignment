//
//  APIService.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 18.08.2023.
//

import Foundation

final class APIService {
    
    static let shared = APIService()
    
    private init() {}
    
    enum APIServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Service method for fetching API data with provided request and data types
    /// - Parameters:
    ///   - request: request with APIRequest type
    ///   - dataType: the data type from existing data models
    ///   - completion: the returned data in the Result wrapper
    public func execute<T:Decodable>(
        _ request: APIRequest,
        expecting dataType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ){
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(APIServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? APIServiceError.failedToGetData))
                return
            }

            do {
                let result = try JSONDecoder().decode(dataType.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    //MARK: - Private
    private func request(from apiRequest: APIRequest) -> URLRequest? {
        guard let url = apiRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.httpMethod
        return request
    }
}
