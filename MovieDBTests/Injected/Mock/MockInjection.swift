//
//  MockInjection.swift
//  MovieDBTests
//
//  Created by William on 04/07/22.
//

import XCTest

@testable import MovieDB
protocol Injection: AnyObject {
    func update(name: String)
}

class MockInjection: Injection {

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

private struct StrongInjectionKey: InjectionKey {
    static var currentValue: Injection = MockInjection()
}

extension InjectedValue {
    var strongInjection: Injection {
        get {
            Self[StrongInjectionKey.self]
        }
        set {
            Self[StrongInjectionKey.self] = newValue
        }
    }
}
