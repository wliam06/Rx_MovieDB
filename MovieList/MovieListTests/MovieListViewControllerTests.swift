//
//  MovieListViewControllerTests.swift
//  MovieDBTests
//
//  Created by William on 02/04/22.
//

import XCTest
import SnapshotTesting
@testable import MovieList

class MovieListViewControllerTests: XCTestCase {
    var vc: MovieListViewController!
    let mockRoute = MockRouter<MovieListRoute>()

    override func setUp() {
        super.setUp()

        vc = MovieListViewController()
        vc.bind(to: MovieListViewModel(router: mockRoute.router))
    }

    override func tearDown() {
        vc = nil
        super.tearDown()
    }

    func testLoadView() {
        assertSnapshot(matching: vc, as: .image)
    }
}

