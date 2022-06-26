//
//  InjectedTests.swift
//  MovieDBTests
//
//  Created by William on 26/06/22.
//

import XCTest

@testable import MovieDB

class ServiceTests {
    @Injected(\.sessionRequest) var session: SessionRequest
    init() {}
}
class InjectedTests: XCTestCase {
    func testInjectServiceSession() {
        let session = ServiceTests()
//        XCTAssertNotNil(session.session)
    }
}
