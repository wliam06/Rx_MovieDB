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
    var repo: MockMovieListRepo?
    let mock = MockMovieResultResponse()
    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        repo = MockMovieListRepo()
    }

    func test_successGetUpComingMovie() {
        var response = [MovieResponse]()

        repo?.stubbedGetUpcomingResult = .just(mock.response())
        repo?.getUpcoming(page: 1).subscribe(onSuccess: {
            response = $0.results
        }, onFailure: nil).disposed(by: disposeBag)

        XCTAssertEqual(mock.response().results, response)
    }

    func test_invalidGetUpComingMovie() {
        let expectation = self.expectation(description: "Should throw error")
        repo?.stubbedGetUpcomingResult = .error(MockErrorResponse.someError)
        repo?.getUpcoming(page: 1).subscribe(onSuccess: { _ in
            XCTFail("Should not success")
        }, onFailure: { _ in
            expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 0.1)
    }

    func test_successGetNowPlayingMovie() {
        var response = [MovieResponse]()

        repo?.stubbedGetNowPlayingResult = .just(mock.response())
        repo?.getNowPlaying(page: 1).subscribe(onSuccess: {
            response = $0.results
        }, onFailure: nil).disposed(by: disposeBag)

        XCTAssertEqual(mock.response().results, response)
    }

    func test_invalidGetNowPlayingMovie() {
        let expectation = self.expectation(description: "Should throw error")
        repo?.stubbedGetNowPlayingResult = .error(MockErrorResponse.someError)
        repo?.getNowPlaying(page: 1).subscribe(onSuccess: { _ in
            XCTFail("Should not success")
        }, onFailure: { _ in
            expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 0.1)
    }

    func test_successGetPopularMovie() {
        var response = [MovieResponse]()

        repo?.stubbedGetPopularResult = .just(mock.response())
        repo?.getPopular(page: 1).subscribe(onSuccess: {
            response = $0.results
        }, onFailure: nil).disposed(by: disposeBag)

        XCTAssertEqual(mock.response().results, response)
    }

    func test_invalidGetPopularMovie() {
        let expectation = self.expectation(description: "Should throw error")
        repo?.stubbedGetPopularResult = .error(MockErrorResponse.someError)
        repo?.getPopular(page: 1).subscribe(onSuccess: { _ in
            XCTFail("Should not success")
        }, onFailure: { _ in
            expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 0.1)
    }
}
