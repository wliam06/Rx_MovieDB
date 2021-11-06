//
//  MockProtocol.swift
//  MovieDBTests
//
//  Created by William on 06/11/21.
//

import Foundation
@testable import MovieDB

protocol MockProtocol: AnyObject {
    var id: Int { get }
}

class MockClass: MockProtocol, Equatable {
    let id: Int

    init(id: Int) {
        self.id = id
    }

    static func == (lhs: MockClass, rhs: MockClass) -> Bool {
        return lhs.id == rhs.id
    }
}

protocol MockConfigurable: AnyObject {}

class MockClassConfigurable: MockConfigurable, Configurable {
    struct MockConfiguration {
        var id: Int
    }

    let mockProtocol: MockProtocol
    var id: Int!

    init(mockProtocol: MockProtocol) {
        self.mockProtocol = mockProtocol
    }

    func configure(configuration: MockConfiguration) {
        self.id = configuration.id
    }
}
