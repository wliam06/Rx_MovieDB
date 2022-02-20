//
//  MovieResponse.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation

struct MovieResultResponse: Codable {
    let page: Int
    let totalPages: Int
    let results: [MovieResponse]

    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}

struct MovieResponse: Codable {
    let id: Int
    let title: String
    let genreIds: [Int]?
    let overview: String
    var posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double?

    private enum CodingKeys: String, CodingKey {
        case id, title, overview
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

    mutating func getMovieImg() -> String {
        return NetworkConfig.imageBaseURL + (posterPath ?? "")
    }
}
