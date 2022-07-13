//
//  MovieDetailResponse.swift
//  MovieDB
//
//  Created by William on 28/02/22.
//

import Foundation

public struct MovieDetailResponse: Codable, Equatable, MoviePoster {
    public static func == (lhs: MovieDetailResponse, rhs: MovieDetailResponse) -> Bool {
        return lhs.id == rhs.id
    }

    public let adult: Bool?
    public let backdropPath: String?
    public let budget: Double?
    public let homepage: String?
    public let id: Int
    public let language: String?
    public let title: String?
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let releaseDate: String?
    public let revenue: Double?
    public let runtime: Double?
    public let tagline: String?
    public let voteAvg: Double?
    public let voteCount: Double?
    public let genres: [MovieGenreResult]?

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

    public func getMovieImg() -> String {
        return NetworkConfig.imageBaseURL + (posterPath ?? "")
    }
}

public struct MovieGenreResult: Codable {
    public let id: Int?
    public let name: String?
}
