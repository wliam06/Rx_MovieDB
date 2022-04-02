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

    func test_successGetNowPlayingMovie() {
        var response = [MovieResponse]()

        repo?.stubbedGetNowPlayingResult = .just(mock.response())
        repo?.getNowPlaying(page: 1).subscribe(onSuccess: {
            response = $0.results
        }, onFailure: nil).disposed(by: disposeBag)

        XCTAssertEqual(mock.response().results, response)
    }

    func test_successGetPopularMovie() {
        var response = [MovieResponse]()

        repo?.stubbedGetPopularResult = .just(mock.response())
        repo?.getPopular(page: 1).subscribe(onSuccess: {
            response = $0.results
        }, onFailure: nil).disposed(by: disposeBag)

        XCTAssertEqual(mock.response().results, response)
    }
}
