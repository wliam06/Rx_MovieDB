//
//  MockNetworkRequest.swift
//  MovieDBTests
//
//  Created by William on 04/12/21.
//

import RxSwift
import Alamofire
@testable import MovieDB

class MockNetworkRequest: NetworkRequest {

    var invokedRequestDecoder = false
    var invokedRequestDecoderCount = 0
    var invokedRequestDecoderParameters: (url: URLRequestConvertible, decoder: JSONDecoder)?
    var invokedRequestDecoderParametersList = [(url: URLRequestConvertible, decoder: JSONDecoder)]()
    var stubbedRequestDecoderResult: Single<Any>!

    func request<T: Codable>(_ url: URLRequestConvertible, decoder: JSONDecoder) -> Single<T> {
        invokedRequestDecoder = true
        invokedRequestDecoderCount += 1
        invokedRequestDecoderParameters = (url, decoder)
        invokedRequestDecoderParametersList.append((url, decoder))
        return stubbedRequestDecoderResult as! Single
    }

    var invokedRequestDecodable = false
    var invokedRequestDecodableCount = 0
    var invokedRequestDecodableParameters: (url: URLRequestConvertible, decodable: Any)?
    var invokedRequestDecodableParametersList = [(url: URLRequestConvertible, decodable: Any)]()
    var stubbedRequestDecodableResult: Single<Any>!

    func request<T: Codable>(_ url: URLRequestConvertible, decodable: T.Type) -> Single<T> {
        invokedRequestDecodable = true
        invokedRequestDecodableCount += 1
        invokedRequestDecodableParameters = (url, decodable)
        invokedRequestDecodableParametersList.append((url, decodable))
        return stubbedRequestDecodableResult as! Single
    }
}
