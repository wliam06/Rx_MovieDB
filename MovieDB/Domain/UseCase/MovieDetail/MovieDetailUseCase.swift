//
//  MovieDetailUseCase.swift
//  MovieDB
//
//  Created by William on 28/02/22.
//

import Foundation

protocol MovieDetailUseCase {
    
}

final class ImpMovieDetailUseCase: MovieDetailUseCase {
    @Injected(\.movieDetailRepo) var repository: MovieDetailRepository
}
