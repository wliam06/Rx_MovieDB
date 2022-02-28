//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by William on 21/12/21.
//

import Foundation

protocol MovieDetailViewModelInput {}
protocol MovieDetailViewModelOutput {}

protocol MovieDetailViewModel: MovieDetailViewModelInput & MovieDetailViewModelOutput {}

final class ImpMovieDetailViewModel: MovieDetailViewModel {

    @Injected(\.movieDetailUC) var usecase: MovieDetailUseCase
    
    private(set) var movieId: Int

    init(_ movieId: Int) {
        self.movieId = movieId
    }
}
