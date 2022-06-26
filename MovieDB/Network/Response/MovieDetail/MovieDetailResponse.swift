//
//  MovieDetailResponse.swift
//  MovieDB
//
//  Created by William on 28/02/22.
//

import Foundation

struct MovieDetailResponse: Codable, Equatable, MoviePoster {
    static func == (lhs: MovieDetailResponse, rhs: MovieDetailResponse) -> Bool {
        return lhs.id == rhs.id
    }

    let adult: Bool?
    let backdropPath: String?
    let budget: Double?
    let homepage: String?
    let id: Int
    let language: String?
    let title: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue: Double?
    let runtime: Double?
    let tagline: String?
    let voteAvg: Double?
    let voteCount: Double?
    let genres: [MovieGenreResult]?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case homepage
        case id
        case language
        case title
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case tagline
        case voteAvg = "vote_average"
        case voteCount = "vote_count"
        case genres
    }

    func getMovieImg() -> String {
        return NetworkConfig.imageBaseURL + (posterPath ?? "")
    }
}

struct MovieGenreResult: Codable {
    let id: Int?
    let name: String?
}
