//
//  NetworkSession.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation
import Alamofire

public protocol SessionRequest: AnyObject {
    func dataRequest(urlRequest: URLRequestConvertible) -> DataRequest
}

public class NetworkSession {
    public static let shared = NetworkSession()
    static var httpHeader: HTTPHeaders {
        return [
            "Content-Type": NetworkConfig.contentType,
            "Authorization": "Bearer \(NetworkConfig.accessToken)"
        ]
    }

    static let session: Session = {
        let config = URLSessionConfiguration.default
        config.httpCookieAcceptPolicy = .never
        config.httpCookieStorage = nil
        config.urlCache = nil
        config.headers = httpHeader
        return Session(configuration: config)
    }()
}

extension NetworkSession: SessionRequest {
    public func dataRequest(urlRequest: URLRequestConvertible) -> DataRequest {
        return NetworkSession.session.request(urlRequest)
    }
}
