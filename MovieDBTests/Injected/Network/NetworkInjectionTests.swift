//
//  NetworkInjectionTests.swift
//  MovieDBTests
//
//  Created by William on 03/07/22.
//

import XCTest

@testable import MovieDB

class MockNetworkRequestInjectionTests: InjectionKey {
    static var currentValue: NetworkRequest = MockNetworkRequest()
}

class MockNetworkSessionInjectionTests: InjectionKey {
    static var currentValue: SessionRequest = MockSessionRequest()
}

extension InjectedValue {
    var sessionRequest: SessionRequest {
        get { Self[MockNetworkSessionInjectionTests.self] }
        set { Self[MockNetworkSessionInjectionTests.self] = newValue }
    }

    var networkRequest: NetworkRequest {
        get { Self[MockNetworkRequestInjectionTests.self] }
        set { Self[MockNetworkRequestInjectionTests.self] = newValue }
    }
}
