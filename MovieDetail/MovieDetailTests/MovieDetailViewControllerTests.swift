//
//  MovieDetailViewControllerTests.swift
//  MovieDetailTests
//
//  Created by William on 11/10/22.
//

import XCTest
import SnapshotTesting

@testable import MovieDetail

class MovieDetailViewControllerTests: XCTestCase {
    var vc: MovieDetailViewController!

    override func setUp() {
        super.setUp()

        vc = MovieDetailViewController()
        let vm = MovieDetailViewModel(1)
        vc.bind(to: vm)
    }

    func testLoadView() {
        assertSnapshot(matching: vc, as: .image)
    }
}
