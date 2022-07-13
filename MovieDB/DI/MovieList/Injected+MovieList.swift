//
//  Injected+MovieList.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Core

// MARK: - MovieList Repo
private struct MovieListRepoProviderKey: InjectionKey {
    static var currentValue: MovieListRepository = ImpMovieListRepository()
}

// MARK: - MovieList UseCase
private struct MovieListUcProviderKey: InjectionKey {
    static var currentValue: MovieListUseCase = ImpMovieListUseCase()
}

extension InjectedValue {
    var movieListRepo: MovieListRepository {
        get { Self[MovieListRepoProviderKey.self] }
        set { Self[MovieListRepoProviderKey.self] = newValue }
    }
    var movieListUC: MovieListUseCase {
        get { Self[MovieListUcProviderKey.self] }
        set { Self[MovieListUcProviderKey.self] = newValue }
    }
}

