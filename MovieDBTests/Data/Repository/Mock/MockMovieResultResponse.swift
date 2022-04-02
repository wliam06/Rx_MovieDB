//
//  MockMovieResultResponse.swift
//  MovieDBTests
//
//  Created by William on 06/03/22.
//

import XCTest

@testable import MovieDB
class MockMovieResultResponse {
    func response() -> MovieResultResponse {
        let response = MovieResponse(
            id: 114,
            title: "Spiderman",
            genreIds: nil,
            overview: "overview",
            posterPath: "poster",
            backdropPath: "backdrop",
            releaseDate: "release",
            voteAverage: 8
        )
        return .init(page: 0, totalPages: 100, results: [response])
    }
}
