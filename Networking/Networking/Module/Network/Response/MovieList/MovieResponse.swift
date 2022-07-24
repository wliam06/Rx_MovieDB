//
//  MovieResponse.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation

public struct MovieResultResponse: Codable, Equatable {
    public let page: Int
    public let totalPages: Int
    public let results: [MovieResponse]

    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}

public protocol MoviePoster: Codable {
    mutating func getMovieImg() -> String
}

public struct MovieResponse: Codable, Equatable, MoviePoster {
    public let id: Int
    public let title: String
    public let genreIds: [Int]?
    public let overview: String
    public var posterPath: String?
    public let backdropPath: String?
    public let releaseDate: String?
    public let voteAverage: Double?

    private enum CodingKeys: String, CodingKey {
        case id, title, overview
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

    public mutating func getMovieImg() -> String {
        return NetworkConfig.imageBaseURL + (posterPath ?? "")
    }
}

extension MovieResultResponse {
    public static func response() -> MovieResponse {
        return .init(
            id: 1,
            title: "title",
            genreIds: [0],
            overview: "overview",
            posterPath: "posterpath",
            backdropPath: "backdrop",
            releaseDate: "date",
            voteAverage: 80
        )
    }
    public static func mock() -> Self {
        return .init(page: 0, totalPages: 0, results: [MovieResultResponse.response()])
    }
}
