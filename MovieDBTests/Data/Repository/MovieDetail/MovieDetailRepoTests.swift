//
//  MovieDetailRepoTests.swift
//  MovieDBTests
//
//  Created by William on 02/04/22.
//

import XCTest
import RxSwift

@testable import MovieDB
class MovieDetailRepoTests: XCTestCase {
    var repo: MockMovieDetailRepo?
    let mock = MockMovieDetailResponse()
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        repo = MockMovieDetailRepo()
    }

    func success_getMovieDetail() {
        var response: MovieDetailResponse?

        repo?.stubbedGetMovieDetailResult = .just(mock.response())
        repo?.getMovieDetail(1).subscribe(onSuccess: {
            response = $0
        }).disposed(by: disposeBag)

        XCTAssertEqual(mock.response(), response!)
    }
}
