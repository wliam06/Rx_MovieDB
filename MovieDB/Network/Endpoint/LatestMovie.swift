//
//  LatestMovie.swift
//  MovieDB
//
//  Created by William on 13/08/21.
//

import Alamofire

enum LatestMovie: URLRequestConvertible {
    case getMovieLatest(param: Parameters)

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        switch self {
        case .getMovieLatest:
            return "/movie/latest"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let baseURL = URL(string: APIConstant.baseURL)!
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .getMovieLatest(let param):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: param)
        }
        return urlRequest
    }
}
