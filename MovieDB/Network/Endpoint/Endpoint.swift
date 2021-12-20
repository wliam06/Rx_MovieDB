//
//  Endpoint.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Alamofire

protocol Endpoint {
    var method: HTTPMethod { get }
    var path: String { get }
    var params: [String: Any]? { get }
}

extension Endpoint {
    var baseURL: String {
        return NetworkConfig.baseUrl
    }

    var urlComponents: URLComponents {
        var components = URLComponents(string: baseURL)!
        components.path = path

        let queryItems = [
            URLQueryItem(name: "api_key", value: NetworkConfig.apiKey)
        ]

        components.queryItems = queryItems
        return components
    }

    var request: URLRequest {
        let urlPath = urlComponents.url!
        var urlRequest = URLRequest(url: urlPath)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
