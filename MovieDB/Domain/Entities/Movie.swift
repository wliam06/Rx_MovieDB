//
//  Movie.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation

struct MoviePage: Equatable {
    let page: Int
    let totalPages: Int
    let movies: [Movie]
}

struct Movie: Equatable, Identifiable {
    typealias Identifier = String
    let id: Identifier
    let title: String?
    let posterPath: String?
    let overview: String?
    let voteAverage: Double?
}

