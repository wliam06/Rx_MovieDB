//
//  MockMovieListUseCase.swift
//  MovieDBTests
//
//  Created by William on 02/04/22.
//

import XCTest
import RxSwift
import RxTest

@testable import MovieDB
class MockMovieListUseCase: MovieListUseCase {

    var invokedFetchNowPlaying = false
    var invokedFetchNowPlayingCount = 0
    var invokedFetchNowPlayingParameters: (page: Int, Void)?
    var invokedFetchNowPlayingParametersList = [(page: Int, Void)]()
    var stubbedFetchNowPlayingResult: Single<MovieResultResponse>!

    func fetchNowPlaying(
        page: Int
    ) -> Single<MovieResultResponse> {
        invokedFetchNowPlaying = true
        invokedFetchNowPlayingCount += 1
        invokedFetchNowPlayingParameters = (page, ())
        invokedFetchNowPlayingParametersList.append((page, ()))
        return stubbedFetchNowPlayingResult
    }

    var invokedFetchUpcoming = false
    var invokedFetchUpcomingCount = 0
    var invokedFetchUpcomingParameters: (page: Int, Void)?
    var invokedFetchUpcomingParametersList = [(page: Int, Void)]()
    var stubbedFetchUpcomingResult: Single<MovieResultResponse>!

    func fetchUpcoming(
        page: Int
    ) -> Single<MovieResultResponse> {
        invokedFetchUpcoming = true
        invokedFetchUpcomingCount += 1
        invokedFetchUpcomingParameters = (page, ())
        invokedFetchUpcomingParametersList.append((page, ()))
        return stubbedFetchUpcomingResult
    }

    var invokedFetchPopular = false
    var invokedFetchPopularCount = 0
    var invokedFetchPopularParameters: (page: Int, Void)?
    var invokedFetchPopularParametersList = [(page: Int, Void)]()
    var stubbedFetchPopularResult: Single<MovieResultResponse>!

    func fetchPopular(
        page: Int
    ) -> Single<MovieResultResponse> {
        invokedFetchPopular = true
        invokedFetchPopularCount += 1
        invokedFetchPopularParameters = (page, ())
        invokedFetchPopularParametersList.append((page, ()))
        return stubbedFetchPopularResult
    }
}
