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

class MockImpMovieDetailRepo: ImpMovieDetailRepository {

    var invokedNetworkSetter = false
    var invokedNetworkSetterCount = 0
    var invokedNetwork: NetworkRequest?
    var invokedNetworkList = [NetworkRequest]()
    var invokedNetworkGetter = false
    var invokedNetworkGetterCount = 0
    var stubbedNetwork: NetworkRequest!

    override var network: NetworkRequest {
        set {
            invokedNetworkSetter = true
            invokedNetworkSetterCount += 1
            invokedNetwork = newValue
            invokedNetworkList.append(newValue)
        }
        get {
            invokedNetworkGetter = true
            invokedNetworkGetterCount += 1
            return stubbedNetwork
        }
    }

    var invokedGetMovieDetail = false
    var invokedGetMovieDetailCount = 0
    var invokedGetMovieDetailParameters: (id: Int, Void)?
    var invokedGetMovieDetailParametersList = [(id: Int, Void)]()
    var stubbedGetMovieDetailResult: Single<MovieDetailResponse>!

    override func getMovieDetail(_ id: Int) -> Single<MovieDetailResponse> {
        invokedGetMovieDetail = true
        invokedGetMovieDetailCount += 1
        invokedGetMovieDetailParameters = (id, ())
        invokedGetMovieDetailParametersList.append((id, ()))
        return super.getMovieDetail(id)
    }
}
