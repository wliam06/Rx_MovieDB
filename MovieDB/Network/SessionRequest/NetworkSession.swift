//
//  NetworkSession.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation
import Alamofire

protocol SessionRequest: AnyObject {
    func dataRequest(urlRequest: URLRequestConvertible) -> DataRequest
}

class NetworkSession {
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
        let sesion = Session(
            configuration: config,
            startRequestsImmediately: true
        )
        return sesion
    }()
}

extension NetworkSession: SessionRequest {
    func dataRequest(urlRequest: URLRequestConvertible) -> DataRequest {
        return NetworkSession.session.request(urlRequest)
    }
}