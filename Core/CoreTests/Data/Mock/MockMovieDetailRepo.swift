//
//  MockMovieDetailRepo.swift
//  CoreTests
//
//  Created by William on 18/07/22.
//

import RxFramework
import Networking
import Core

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
