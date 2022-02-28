//
//  MovieDetailRepository.swift
//  MovieDB
//
//  Created by William on 28/02/22.
//

import Foundation

protocol MovieDetailRepository {}

final class ImpMovieDetailRepository: MovieDetailRepository {
    @Injected(\.networkRequest) var network: NetworkRequest
}
