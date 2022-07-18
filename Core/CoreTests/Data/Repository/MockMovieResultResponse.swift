//
//  MockMovieResultResponse.swift
//  MovieDBTests
//
//  Created by William on 06/03/22.
//


@testable import Networking
public class MockMovieResultResponse {
    public init() {}
    public func response() -> MovieResultResponse {
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

public class MockMovieDetailResponse {
    public static var shared = MockMovieDetailResponse()
    public func response() -> MovieDetailResponse {
        let genres = MovieGenreResult(id: 1, name: "genre")
        return MovieDetailResponse(
            adult: false,
            backdropPath: "/test",
            budget: 10000,
            homepage: "homepage",
            id: 1,
            language: "ID",
            title: "Movie Title",
            overview: "overview",
            popularity: 8,
            posterPath: "posterpath",
            releaseDate: "release",
            revenue: 10000,
            runtime: 1000,
            tagline: "tagline",
            voteAvg: 12,
            voteCount: 12,
            genres: [genres]
        )
    }
}
