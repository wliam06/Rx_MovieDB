//
//  MovieDetailUseCaseTests.swift
//  MovieDBTests
//
//  Created by William on 02/04/22.
//

import XCTest
import RxFramework
import Networking

@testable import Core

class MovieDetailUseCaseTests: XCTestCase {
    var usecase: ImpMovieDetailUseCase!
    var repo: MockMovieDetailRepo!
    let mock = MockMovieDetailResponse.shared
    let mockMovie = MockMovieDetailModel()

    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        usecase = ImpMovieDetailUseCase()
        repo = MockMovieDetailRepo()
        usecase.repository = repo
    }
    override func tearDown() {
        usecase = nil
        repo = nil
        super.tearDown()
    }

    func test_successFetchMovieDetail() {
        var movie: MovieDetailModel!
        repo.stubbedGetMovieDetailResult = .just(mock.response())
        usecase.fetchMovieDetail(id: 1).subscribe(onSuccess: {
            movie = $0
        }).disposed(by: disposeBag)

        XCTAssertTrue(repo.invokedGetMovieDetail)
        XCTAssertEqual(movie, mockMovie.result())
    }
}

class MockMovieDetailModel {
    func result() -> MovieDetailModel {
        return MovieDetailModel(
            title: "Movie Title",
            releaseDate: "release",
            overview: "overview",
            movieImg: "movies.png",
            genres: nil
        )
    }
}

