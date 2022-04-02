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
    var scheduler: ConcurrentDispatchQueueScheduler?
    var repo: MockMovieListRepo?

    let disposeBag = DisposeBag()
    override func setUp() {
        super.setUp()
        repo = MockMovieListRepo()
    }

    func test_successGetUpComingMovie() {
        let mock = MockMovieResultResponse()
        let expectation = self.expectation(description: "success get upcoming movie list")
        var response = [MovieResponse]()

        repo?.stubbedGetUpcomingResult = .just(mock.response())
        repo?.getUpcoming(page: 1).subscribe(onSuccess: {
            response = $0.results
            expectation.fulfill()
        }, onFailure: nil).disposed(by: disposeBag)
        waitForExpectations(timeout: 1)

        XCTAssertEqual(mock.response().results, response)
    }

    func test_successGetNowPlayingMovie() {
        let mock = MockMovieResultResponse()
        let expectation = self.expectation(description: "success get now playing movie list")
        var response = [MovieResponse]()

        repo?.stubbedGetNowPlayingResult = .just(mock.response())
        repo?.getNowPlaying(page: 1).subscribe(onSuccess: {
            response = $0.results
            expectation.fulfill()
        }, onFailure: nil).disposed(by: disposeBag)
        waitForExpectations(timeout: 1)

        XCTAssertEqual(mock.response().results, response)
    }

    func test_successGetPopularMovie() {
        let mock = MockMovieResultResponse()
        let expectation = self.expectation(description: "success get now playing movie list")
        var response = [MovieResponse]()

        repo?.stubbedGetPopularResult = .just(mock.response())
        repo?.getPopular(page: 1).subscribe(onSuccess: {
            response = $0.results
            expectation.fulfill()
        }, onFailure: nil).disposed(by: disposeBag)
        waitForExpectations(timeout: 1)

        XCTAssertEqual(mock.response().results, response)
    }
}
