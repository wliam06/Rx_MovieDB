//
//  MockMovieDetailUseCase.swift
//  MovieDBTests
//
//  Created by William on 02/04/22.
//

import XCTest
import RxSwift

@testable import MovieDB
class MockMovieDetailUseCase: MovieDetailUseCase {

    var invokedFetchMovieDetail = false
    var invokedFetchMovieDetailCount = 0
    var invokedFetchMovieDetailParameters: (id: Int, Void)?
    var invokedFetchMovieDetailParametersList = [(id: Int, Void)]()
    var stubbedFetchMovieDetailResult: Single<MovieDetailResponse>!

    func fetchMovieDetail(id: Int) -> Single<MovieDetailResponse> {
        invokedFetchMovieDetail = true
        invokedFetchMovieDetailCount += 1
        invokedFetchMovieDetailParameters = (id, ())
        invokedFetchMovieDetailParametersList.append((id, ()))
        return stubbedFetchMovieDetailResult
    }
}
