//
//  MockMovieRepository.swift
//  MovieDBTests
//
//  Created by William on 04/12/21.
//

import RxSwift
@testable import MovieDB

class MockMovieRepository: MovieRepository {
    var invokedGetUpcoming = false
    var invokedGetUpcomingCount = 0
    var invokedGetUpcomingParameters: (page: Int, Void)?
    var invokedGetUpcomingParametersList = [(page: Int, Void)]()
    var stubbedGetUpcomingResult: Observable<MovieResultResponse>!

    func getUpcoming(page: Int) -> Observable<MovieResultResponse> {
        invokedGetUpcoming = true
        invokedGetUpcomingCount += 1
        invokedGetUpcomingParameters = (page, ())
        invokedGetUpcomingParametersList.append((page, ()))
        return stubbedGetUpcomingResult
    }
}
