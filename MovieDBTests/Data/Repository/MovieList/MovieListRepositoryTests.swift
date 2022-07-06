//
//  MovieListRepositoryTests.swift
//  MovieDBTests
//
//  Created by William on 06/03/22.
//

import XCTest
import RxSwift

@testable import MovieDB
class MovieListRepositoryTests: XCTestCase {

    var sut: ImpMovieListRepository!
    let mock = MockMovieResultResponse()

    var network: MockNetworkRequest!
    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()

        sut = ImpMovieListRepository()
        network = MockNetworkRequest()
        sut.network = network
    }

    override func tearDown() {
        sut = nil
        network = nil
        super.tearDown()
    }

    func test_successGetUpComingMovie() {
        network.stubbedRequestResult = .just(mock.response())
        _ = sut.getUpcoming(page: 1)
        XCTAssertTrue(network.invokedRequest)
    }

    func test_invalidGetUpComingMovie() {
        network.stubbedRequestResult = .error(MockErrorResponse.someError)
        _ = sut.getUpcoming(page: 1)
        XCTAssertTrue(network.invokedRequest)
    }

    func test_successGetNowPlayingMovie() {
        network.stubbedRequestResult = .just(mock.response())
        _ = sut.getNowPlaying(page: 1)
        XCTAssertTrue(network.invokedRequest)
    }

    func test_invalidGetNowPlayingMovie() {
        network.stubbedRequestResult = .error(MockErrorResponse.someError)
        _ = sut.getNowPlaying(page: 1)
        XCTAssertTrue(network.invokedRequest)
    }

    func test_successGetPopularMovie() {
        network.stubbedRequestResult = .just(mock.response())
        _ = sut.getPopular(page: 1)
        XCTAssertTrue(network.invokedRequest)
    }

    func test_invalidGetPopularMovie() {
        network.stubbedRequestResult = .error(MockErrorResponse.someError)
        _ = sut.getPopular(page: 1)
        XCTAssertTrue(network.invokedRequest)
    }
}
