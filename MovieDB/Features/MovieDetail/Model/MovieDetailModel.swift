//
//  MovieDetailModel.swift
//  MovieDB
//
//  Created by William on 26/06/22.
//

import Foundation

struct MovieDetailModel: Equatable {
    static func == (lhs: MovieDetailModel, rhs: MovieDetailModel) -> Bool {
        return lhs.title == rhs.title
    }
    
    let title: String
    let releaseDate: String
    let overview: String
    let movieImg: String
    let genres: [MovieGenreResult]?
}
