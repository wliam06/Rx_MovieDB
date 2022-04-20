//
//  MovieDetailRepoTests.swift
//  MovieDBTests
//
//  Created by William on 02/04/22.
//

import XCTest
import RxSwift

@testable import MovieDB
class MovieDetailRepositoryTests: XCTestCase {
    var repo: MockMovieDetailRepo? // SUT
    var mockRepo: MockImpMovieDetailRepo?
    let mock = MockMovieDetailResponse()
    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        mockRepo = MockImpMovieDetailRepo()
        repo = MockMovieDetailRepo()
    }

    func test_successGetMovieDetail() {
        var response: MovieDetailResponse?

        repo?.stubbedGetMovieDetailResult = .just(mock.response())
        repo?.getMovieDetail(1).subscribe(onSuccess: {
            response = $0
        }).disposed(by: disposeBag)

        XCTAssertEqual(mock.response(), response!)
        XCTAssertNotNil(response)
    }

    func test_invalidGetMovieDetail() {
        let expectation = self.expectation(description: "Should throw error")
        repo?.stubbedGetMovieDetailResult = .error(MockErrorResponse.someError)
        repo?.getMovieDetail(1).subscribe(onSuccess: { _ in
            XCTFail("Should not success")
        }, onFailure: { _ in
            expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 0.1)
    }
}
