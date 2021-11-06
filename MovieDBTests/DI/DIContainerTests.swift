//
//  DIContainerTests.swift
//  MovieDBTests
//
//  Created by William on 06/11/21.
//

import XCTest

@testable import MovieDB
class DIContainerTests: XCTestCase {
    var resolver: Container!

    override func setUp() {
        super.setUp()

        resolver = DIContainer()
    }

    func test_successRegister() {
        resolver.register(type: MockProtocol.self) { _ in
            MockClass(id: 1)
        }

        let mockObj = resolver.resolve(type: MockProtocol.self)
        XCTAssertTrue(mockObj is MockClass)
    }

    func test_successInstanceSameClass() {
        resolver.register(type: MockClass.self) { _ in
            MockClass(id: 1)
        }

        let mockObj1 = resolver.resolve(type: MockClass.self)
        let mockObj2 = resolver.resolve(type: MockClass.self)
        XCTAssertTrue(mockObj1 == mockObj2)
    }

    func test_successRegisterProtocolAndClass() {
        resolver.register(type: MockProtocol.self) { _ in MockClass(id: 1) }
        resolver.register(type: MockClass.self) { _ in MockClass(id: 2) }

        let resolvedProtocol = resolver.resolve(type: MockProtocol.self)
        let resolvedClass = resolver.resolve(type: MockClass.self)

        XCTAssertEqual(resolvedProtocol?.id, 1)
        XCTAssertEqual(resolvedClass?.id, 2)
    }

    func test_successRegisterClassWithConfigurable() {
        resolver.register(type: MockProtocol.self) { _ in MockClass(id: 1) }
        resolver.register(type: MockClassConfigurable.self) { container -> AnyObject in
            return MockClassConfigurable(
                mockProtocol: container.resolve(type: MockProtocol.self)!
            )
        }

        let configuration = MockClassConfigurable.MockConfiguration(id: 2)
        let mockConfigurable = resolver.resolve(
            type: MockClassConfigurable.self,
            configuration: configuration
        )
        
        XCTAssertEqual(mockConfigurable?.id, 2)
    }
}
