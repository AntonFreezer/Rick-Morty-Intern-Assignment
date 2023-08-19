//
//  APIRequest.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 18.08.2023.
//

import Foundation

final class APIRequest {
    
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    
    public let httpMethod = "GET"
    private let endpoint: APIEndpoint
    
    /// Path components '/' for request, if present
    private let pathComponents: [String]
    /// Query parameters '?...&...&' for request, if present
    private let queryParameters: [URLQueryItem]
    
    /// String URL constructed for the request
    private var urlString: String {
        var string = Constants.baseURL
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    
    /// Computed property for constructing request URL
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// General initializer for customizable API request
    public init(
        endpoint: APIEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    /// Convenience initializer for request construction by desired URL
    convenience init?(url: URL) {
        let urlString = url.absoluteString
        if !urlString.contains(Constants.baseURL) { return nil }
        
        let trimmed = urlString.replacingOccurrences(of: Constants.baseURL+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let endpoint = APIEndpoint(rawValue: endpointString) {
                    self.init(endpoint: endpoint, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty {
                let endpointString = components[0]
                let queryItemsString = components[1]
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1])
                })
                if let endpoint = APIEndpoint(rawValue: endpointString) {
                    self.init(endpoint: endpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
}

extension APIRequest {
    /// predefined API request for all characters
    static let allCharactersRequest = APIRequest(endpoint: .character)
}
