//
//  InjectedTests.swift
//  MovieDBTests
//
//  Created by William on 26/06/22.
//

import XCTest
@testable import MovieDB

class MockInjectedValue: InjectionKey {
    
}

class InjectedTests: XCTest {
    @Injected(\.strongInjection) var injectTest: Injection

    func testBasicInjection() {
        let mock = MockInjection()
        injectTest.update(name: "Strong")
        XCTAssertTrue(mock.invokedUpdate)
    }
}
