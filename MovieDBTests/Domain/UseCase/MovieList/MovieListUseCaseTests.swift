//
//  MovieListUseCaseTests.swift
//  MovieDBTests
//
//  Created by William on 02/04/22.
//

import XCTest
import RxSwift

@testable import MovieDB
class MovieListUseCaseTests: XCTestCase {
    var usecase: MockMovieListUseCase?
    let mock = MockMovieResultResponse()
    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        usecase = MockMovieListUseCase()
    }

    func test_successFetchNowPlaying() {
        var response = [MovieResponse]()

        usecase?.stubbedFetchNowPlayingResult = .just(mock.response())
        usecase?.fetchNowPlaying(page: 1).subscribe(onSuccess: {
            response = $0.results
        }).disposed(by: disposeBag)

        XCTAssertEqual(mock.response().results, response)
    }

    func test_successFetchUpcoming() {
        var response = [MovieResponse]()

        usecase?.stubbedFetchUpcomingResult = .just(mock.response())
        usecase?.fetchUpcoming(page: 1).subscribe(onSuccess: {
            response = $0.results
        }).disposed(by: disposeBag)

        XCTAssertEqual(mock.response().results, response)
    }

    func test_successFetchPopular() {
        var response = [MovieResponse]()

        usecase?.stubbedFetchPopularResult = .just(mock.response())
        usecase?.fetchPopular(page: 1).subscribe(onSuccess: {
            response = $0.results
        }).disposed(by: disposeBag)

        XCTAssertEqual(mock.response().results, response)
    }
}
