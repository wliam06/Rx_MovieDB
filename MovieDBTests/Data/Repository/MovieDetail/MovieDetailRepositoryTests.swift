//
//  MovieDetailRepoTests.swift
//  MovieDBTests
//
//  Created by William on 02/04/22.
//

import XCTest
import RxSwift

@testable import MovieDB
class MovieDetailRepositoryTests: XCTestCase {
    var sut: ImpMovieDetailRepository! // sut
    var network: MockNetworkRequest!
    let mock = MockMovieDetailResponse()
    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        sut = ImpMovieDetailRepository()
        network = MockNetworkRequest()
        sut.network = network
    }

    func test_successGetMovieDetail() {
        network.stubbedRequestResult = .just(mock.response())
        _ = sut.getMovieDetail(1)
        XCTAssertTrue(network.invokedRequest)
    }

    func test_invalidGetMovieDetail() {
        network.stubbedRequestResult = .error(MockErrorResponse.someError)
        _ = sut.getMovieDetail(1)
        XCTAssertTrue(network.invokedRequest)
    }
}
