//
//  MovieDetailModel.swift
//  MovieDB
//
//  Created by William on 26/06/22.
//

import Foundation
import Networking

public struct MovieDetailModel: Equatable {
    public static func == (lhs: MovieDetailModel, rhs: MovieDetailModel) -> Bool {
        return lhs.title == rhs.title
    }

    public let title: String
    public let releaseDate: String
    public let overview: String
    public let movieImg: String
    public let genres: [MovieGenreResult]?
}
