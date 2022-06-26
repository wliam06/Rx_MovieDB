//
//  MovieDetailUseCaseTests.swift
//  MovieDBTests
//
//  Created by William on 02/04/22.
//

import XCTest
import RxSwift

@testable import MovieDB
class MovieDetailUseCaseTests: XCTestCase {
    var usecase: ImpMovieDetailUseCase!
    var repo: MockMovieDetailRepo!
    let mock = MockMovieDetailResponse()
    let mockMovie = MockMovieDetailModel()

    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        usecase = ImpMovieDetailUseCase()
        repo = MockMovieDetailRepo()
        usecase.repository = repo
    }
    override func tearDown() {
        super.tearDown()
        usecase = nil
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
