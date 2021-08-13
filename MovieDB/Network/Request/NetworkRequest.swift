//
//  NetworkRequest.swift
//  MovieDB
//
//  Created by William on 13/08/21.
//

import RxSwift
import Alamofire

public enum NetworkError: Error {
    case BadRequest
    case Forbidden
    case NotFound
    case InternalServerError
    case ServiceUnavailable

    func handleCode(errorCode: NetworkError, callback: (() -> Void)?) {
        NetworkReachability.shared.showErrorResponse(errorCode, callback: callback)
    }
}

public protocol NetworkRequest {
    /// Request url within codable object
    func request<T: Codable>(_ url: URLRequestConvertible, decoder: JSONDecoder) -> Single<T>
}

class NetworkSessionRequest: NetworkRequest {
    private var session: SessionRequest

    init(_ session: SessionRequest = NetworkSession()) {
        self.session = session
    }

    func request<T: Codable>(_ url: URLRequestConvertible, decoder: JSONDecoder) -> Single<T> {
        return Single<T>.create { observer -> Disposable in
            let request = self.session.dataRequest(urlRequest: url)
                .validate()
                .responseDecodable(decoder: decoder) { (response: DataResponse<T, AFError>) in
                    switch (response.response?.statusCode, response.result) {
                    case (.some(200..<300), .success(let data)):
                        observer(.success(data))
                    case (.some(400), _):
                        observer(.failure(NetworkError.BadRequest))
                    case (.some(403), _):
                        observer(.failure(NetworkError.Forbidden))
                    case (.some(404), _):
                        observer(.failure(NetworkError.NotFound))
                    case (.some(500), _):
                        observer(.failure(NetworkError.InternalServerError))
                    case (.some(503), _):
                        observer(.failure(NetworkError.ServiceUnavailable))
                    default:
                        observer(.failure(response.error!))
                    }
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }
}
