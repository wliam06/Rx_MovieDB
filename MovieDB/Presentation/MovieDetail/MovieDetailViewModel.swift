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

final class ImpMovieDetailViewModel: MovieDetailViewModel {}
