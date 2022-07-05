//
//  InjectedTests.swift
//  MovieDBTests
//
//  Created by William on 26/06/22.
//

import XCTest

@testable import MovieDB
class MockInjectionTest: XCTestCase {
    var sut: ImpInjection!
    var mock: MockImpInjection!

    override func setUp() {
        super.setUp()
        sut = ImpInjection(name: "NAME")
        mock = MockImpInjection()
        sut.injected = mock
    }

    override func tearDown() {
        sut = nil
        mock = nil
        super.tearDown()
    }

    func testBasicInject() {
        sut.update(name: "Mock")
        XCTAssert(sut.name!.contains("Mock"))
    }
}
