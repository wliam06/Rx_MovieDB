//
//  NetworkSession.swift
//  MovieDB
//
//  Created by William on 13/08/21.
//

import Alamofire

protocol SessionRequest: AnyObject {
    func dataRequest(urlRequest: URLRequestConvertible) -> DataRequest
}

class NetworkSession {
    static var httpHeader: HTTPHeaders {
        return [
            "Content-Type": "application/json;charset=utf-8",
            "Authorization": "Bearer \(APIConstant.accessToken)"
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
