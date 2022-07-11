//
//  NetworkRequest.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxFramework
import RxSwift
import Alamofire
import Core

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

protocol NetworkRequest: AnyObject {
    func request<T: Codable>(_ url: URLRequestConvertible, decodable: T.Type) -> Single<T>
}

class NetworkSessionRequest: NetworkRequest {
    @Injected(\.sessionRequest) var session: SessionRequest

    func request<T: Codable>(_ url: URLRequestConvertible, decodable: T.Type) -> Single<T> {
        return Single<T>.create { observer -> Disposable in
            let request = self.session.dataRequest(urlRequest: url)
                .validate()
                .responseData { response in
                    switch (response.response?.statusCode, response.result) {
                    case (.some(200..<300), .success(let data)):
                        do {
                            let decode = try JSONDecoder().decode(T.self, from: data)
                            observer(.success(decode))
                        } catch {
                            observer(.failure(error))
                        }
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
//                        Logger.error(response.error?.localizedDescription ?? "Error Request")
                        observer(.failure(response.error!))
                    }
                }

            return Disposables.create {
                request.cancel()
            }
        }
    }

}

extension NetworkSessionRequest {
    var decoder: JSONDecoder {
        return JSONDecoder()
    }
}
