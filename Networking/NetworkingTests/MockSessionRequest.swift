//
//  MockSessionRequest.swift
//  MovieDBTests
//
//  Created by William on 03/07/22.
//

import XCTest
import Alamofire

@testable import Networking

public class MockSessionRequest: SessionRequest {

    var invokedDataRequest = false
    var invokedDataRequestCount = 0
    var invokedDataRequestParameters: (urlRequest: URLRequestConvertible, Void)?
    var invokedDataRequestParametersList = [(urlRequest: URLRequestConvertible, Void)]()
    var stubbedDataRequestResult: DataRequest!

    public func dataRequest(urlRequest: URLRequestConvertible) -> DataRequest {
        invokedDataRequest = true
        invokedDataRequestCount += 1
        invokedDataRequestParameters = (urlRequest, ())
        invokedDataRequestParametersList.append((urlRequest, ()))
        return stubbedDataRequestResult
    }
}
