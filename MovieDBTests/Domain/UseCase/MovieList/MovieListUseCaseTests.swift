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
    var usecase: ImpMovieListUseCase!
    var repository: MockMovieListRepo!
    let mock = MockMovieResultResponse()
    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        usecase = ImpMovieListUseCase()
        repository = MockMovieListRepo()
        usecase.repository = repository
    }

    override func tearDown() {
        super.tearDown()
        usecase = nil
        repository = nil
    }

    func test_successFetchNowPlaying() {
        let expectation = self.expectation(description: "Success get now playing movie")
        repository.stubbedGetNowPlayingResult = .just(mock.response())
        _ = usecase.fetchNowPlaying(page: 1).subscribe(onSuccess: { _ in
            expectation.fulfill()
        }).disposed(by: disposeBag)

        XCTAssertEqual(repository.invokedGetNowPlayingCount, 1)
        wait(for: [expectation], timeout: 0.1)
    }

    func test_errorFetchNowPlaying() {
        let expectation = self.expectation(description: "Error get now playing movie")
        repository.stubbedGetNowPlayingResult = .error(MockErrorResponse.someError)
        usecase.fetchNowPlaying(page: 1).subscribe(onSuccess: nil, onFailure: { _ in
            expectation.fulfill()
        }).disposed(by: disposeBag)

        XCTAssertEqual(repository.invokedGetNowPlayingCount, 1)
        wait(for: [expectation], timeout: 0.1)
    }

    func test_successFetchUpcomingMovie() {
        let expectation = self.expectation(description: "Success get upcoming movie")
        repository.stubbedGetUpcomingResult = .just(mock.response())
        usecase.fetchUpcoming(page: 1).subscribe(onSuccess: { _ in
            expectation.fulfill()
        }).disposed(by: disposeBag)

        XCTAssertEqual(repository.invokedGetUpcomingCount, 1)
        wait(for: [expectation], timeout: 0.1)
    }

    func test_errorFetchUpcomingMovie() {
        let expectation = self.expectation(description: "Error get upcoming movie")
        repository.stubbedGetUpcomingResult = .error(MockErrorResponse.someError)
        usecase.fetchUpcoming(page: 1).subscribe(onSuccess: nil, onFailure: { _ in
            expectation.fulfill()
        }).disposed(by: disposeBag)

        XCTAssertEqual(repository.invokedGetUpcomingCount, 1)
        wait(for: [expectation], timeout: 0.1)
    }

    func test_successFetchPopularMovie() {
        let expectation = self.expectation(description: "Success get popular movie")
        repository.stubbedGetPopularResult = .just(mock.response())
        usecase.fetchPopular(page: 1).subscribe(onSuccess: { _ in
            expectation.fulfill()
        }).disposed(by: disposeBag)

        XCTAssertEqual(repository.invokedGetPopularCount, 1)
        wait(for: [expectation], timeout: 0.1)
    }

    func test_errorFetchPopularMovie() {
        let expectation = self.expectation(description: "Error get popular movie")
        repository.stubbedGetPopularResult = .error(MockErrorResponse.someError)
        usecase.fetchPopular(page: 1).subscribe(onSuccess: nil, onFailure: { _ in
            expectation.fulfill()
        }).disposed(by: disposeBag)

        XCTAssertEqual(repository.invokedGetPopularCount, 1)
        wait(for: [expectation], timeout: 0.1)
    }
}
