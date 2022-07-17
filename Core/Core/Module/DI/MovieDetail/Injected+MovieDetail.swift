//
//  Injected+MovieDetail.swift
//  MovieDB
//
//  Created by William on 28/02/22.
//

import Foundation

// MARK: - MovieDetail Repo
private struct MovieDetailRepoProviderKey: InjectionKey {
    static var currentValue: MovieDetailRepository = ImpMovieDetailRepository()
}

// MARK: - MovieList UseCase
private struct MovieDetailUcProviderKey: InjectionKey {
    static var currentValue: MovieDetailUseCase = ImpMovieDetailUseCase()
}

extension InjectedValue {
    public var movieDetailRepo: MovieDetailRepository {
        get { Self[MovieDetailRepoProviderKey.self] }
        set { Self[MovieDetailRepoProviderKey.self] = newValue }
    }
    public var movieDetailUC: MovieDetailUseCase {
        get { Self[MovieDetailUcProviderKey.self] }
        set { Self[MovieDetailUcProviderKey.self] = newValue }
    }
}
