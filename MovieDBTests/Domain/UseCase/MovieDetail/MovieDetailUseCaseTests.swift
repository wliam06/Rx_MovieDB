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
    var usecase: MockMovieDetailUseCase?
    let mock = MockMovieDetailResponse()
    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        usecase = MockMovieDetailUseCase()
    }

    func test_successFetchMovieDetail() {
        var response: MovieDetailResponse?

        usecase?.stubbedFetchMovieDetailResult = .just(mock.response())
        usecase?.fetchMovieDetail(id: 1).subscribe(onSuccess: {
            response = $0
        }).disposed(by: disposeBag)

        XCTAssertEqual(mock.response(), response!)
    }
}
