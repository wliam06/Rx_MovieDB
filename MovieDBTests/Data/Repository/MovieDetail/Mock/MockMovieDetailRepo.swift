//
//  MockMovieDetailRepo.swift
//  MovieDBTests
//
//  Created by William on 02/04/22.
//

import XCTest
import RxSwift
import RxTest

@testable import MovieDB
class MockMovieDetailRepo: MovieDetailRepository {

    var invokedGetMovieDetail = false
    var invokedGetMovieDetailCount = 0
    var invokedGetMovieDetailParameters: (id: Int, Void)?
    var invokedGetMovieDetailParametersList = [(id: Int, Void)]()
    var stubbedGetMovieDetailResult: Single<MovieDetailResponse>!

    func getMovieDetail(_ id: Int) -> Single<MovieDetailResponse> {
        invokedGetMovieDetail = true
        invokedGetMovieDetailCount += 1
        invokedGetMovieDetailParameters = (id, ())
        invokedGetMovieDetailParametersList.append((id, ()))
        return stubbedGetMovieDetailResult
    }
}
