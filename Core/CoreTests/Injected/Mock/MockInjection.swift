//
//  MockInjection.swift
//  MovieDBTests
//
//  Created by William on 04/07/22.
//

import XCTest

@testable import Core

class MockImpInjectionKey: InjectionKey {
    static var currentValue: InjectionProtocol = MockImpInjection()
}


extension InjectedValue {
    var strongInjection: InjectionProtocol {
        get { Self[MockImpInjectionKey.self] }
        set { Self[MockImpInjectionKey.self] = newValue }
    }
}

// Mock Injection
class MockImpInjection: InjectionProtocol {

    var invokedUpdate = false
    var invokedUpdateCount = 0
    var invokedUpdateParameters: (name: String, Void)?
    var invokedUpdateParametersList = [(name: String, Void)]()

    func update(name: String) {
        invokedUpdate = true
        invokedUpdateCount += 1
        invokedUpdateParameters = (name, ())
        invokedUpdateParametersList.append((name, ()))
    }
}
