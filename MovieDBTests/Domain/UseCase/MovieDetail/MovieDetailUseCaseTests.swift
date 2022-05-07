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
        repo.stubbedGetMovieDetailResult = .just(mock.response())
        _ = usecase.fetchMovieDetail(id: 1)

        XCTAssertEqual(repo.invokedGetMovieDetailCount, 1)
        XCTAssertTrue(repo.invokedGetMovieDetail)
    }
}
