//
//  InjectedTests.swift
//  MovieDBTests
//
//  Created by William on 26/06/22.
//

import XCTest
@testable import Core

class MockInjectionTest: XCTestCase {
    var sut: ImpInjection!
    var sutWeak: ImpWeakInjection!
    var mock: MockImpInjection!
    var mockWeak: MockImpInjection!

    override func setUp() {
        super.setUp()
        sut = ImpInjection(name: "NAME")
        sutWeak = ImpWeakInjection(name: "NAME2")
        mock = MockImpInjection()
        mockWeak = MockImpInjection()
        sut.injected = mock
        sutWeak.injected = mockWeak
    }

    override func tearDown() {
        sut = nil
        mock = nil
        sutWeak = nil
        mockWeak = nil
        super.tearDown()
    }

    func testBasicInject() {
        sut.update(name: "Mock")
        XCTAssert(sut.name!.contains("Mock"))
    }

    func testWeakRefInject() {
        sutWeak.update(name: "HAI")
        XCTAssertTrue(sutWeak.name!.contains("HAI"))
        var obj: ImpWeakInjection? = ImpWeakInjection()
        obj?.update(name: "Hello")
        obj = nil
        sutWeak.injected = nil
        XCTAssertTrue(obj == nil)
        XCTAssertTrue(sutWeak.injected == nil)
    }
}
