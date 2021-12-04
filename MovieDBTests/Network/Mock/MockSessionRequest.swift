//
//  MockSessionRequest.swift
//  MovieDBTests
//
//  Created by William on 04/12/21.
//

import XCTest
import Alamofire

@testable import MovieDB

class MockSessionRequest: SessionRequest {

    var invokedDataRequest = false
    var invokedDataRequestCount = 0
    var invokedDataRequestParameters: (urlRequest: URLRequestConvertible, Void)?
    var invokedDataRequestParametersList = [(urlRequest: URLRequestConvertible, Void)]()
    var stubbedDataRequestResult: DataRequest!

    func dataRequest(urlRequest: URLRequestConvertible) -> DataRequest {
        invokedDataRequest = true
        invokedDataRequestCount += 1
        invokedDataRequestParameters = (urlRequest, ())
        invokedDataRequestParametersList.append((urlRequest, ()))
        return stubbedDataRequestResult
    }
}
