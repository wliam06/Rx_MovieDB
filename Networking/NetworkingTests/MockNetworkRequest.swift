//
//  MockNetworkRequest.swift
//  MovieDBTests
//
//  Created by William on 11/04/22.
//

import XCTest
import RxFramework
import Alamofire

public class MockNetworkRequest: NetworkRequest {
    public init() {}
    public var invokedRequest = false
    var invokedRequestCount = 0
    var invokedRequestParameters: (url: URLRequestConvertible, decodable: Any)?
    var invokedRequestParametersList = [(url: URLRequestConvertible, decodable: Any)]()
    public var stubbedRequestResult: Single<Any>!

    public func request<T: Codable>(_ url: URLRequestConvertible, decodable: T.Type) -> Single<T> {
        invokedRequest = true
        invokedRequestCount += 1
        invokedRequestParameters = (url, decodable)
        invokedRequestParametersList.append((url, decodable))
        return Single<T>.create { observer in
            do {
                let decode = try JSONDecoder().decode(T.self, from: Data())
                observer(.success(decode))
            } catch {
                observer(.failure(MockErrorResponse.someError))
            }

            return Disposables.create {}
        }
    }
    
}
