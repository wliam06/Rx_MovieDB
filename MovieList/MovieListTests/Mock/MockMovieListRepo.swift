//
//  MockMovieListRepo.swift
//  MovieDBTests
//
//  Created by William on 06/03/22.
//

import XCTest
import RxFramework
import Networking

@testable import Core
public class MockMovieListRepo: MovieListRepository {

    var invokedGetUpcoming = false
    var invokedGetUpcomingCount = 0
    var invokedGetUpcomingParameters: (page: Int, Void)?
    var invokedGetUpcomingParametersList = [(page: Int, Void)]()
    var stubbedGetUpcomingResult: Single<MovieResultResponse>!

    public func getUpcoming(page: Int) -> Single<MovieResultResponse> {
        invokedGetUpcoming = true
        invokedGetUpcomingCount += 1
        invokedGetUpcomingParameters = (page, ())
        invokedGetUpcomingParametersList.append((page, ()))
        return stubbedGetUpcomingResult
    }

    var invokedGetNowPlaying = false
    var invokedGetNowPlayingCount = 0
    var invokedGetNowPlayingParameters: (page: Int, Void)?
    var invokedGetNowPlayingParametersList = [(page: Int, Void)]()
    var stubbedGetNowPlayingResult: Single<MovieResultResponse>!

    public func getNowPlaying(page: Int) -> Single<MovieResultResponse> {
        invokedGetNowPlaying = true
        invokedGetNowPlayingCount += 1
        invokedGetNowPlayingParameters = (page, ())
        invokedGetNowPlayingParametersList.append((page, ()))
        return stubbedGetNowPlayingResult
    }

    var invokedGetPopular = false
    var invokedGetPopularCount = 0
    var invokedGetPopularParameters: (page: Int, Void)?
    var invokedGetPopularParametersList = [(page: Int, Void)]()
    var stubbedGetPopularResult: Single<MovieResultResponse>!

    public func getPopular(page: Int) -> Single<MovieResultResponse> {
        invokedGetPopular = true
        invokedGetPopularCount += 1
        invokedGetPopularParameters = (page, ())
        invokedGetPopularParametersList.append((page, ()))
        return stubbedGetPopularResult
    }
}
