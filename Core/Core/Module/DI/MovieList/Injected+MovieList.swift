//
//  Injected+MovieList.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

// MARK: - MovieList Repo
private struct MovieListRepoProviderKey: InjectionKey {
    public static var currentValue: MovieListRepository = ImpMovieListRepository()
}

// MARK: - MovieList UseCase
private struct MovieListUcProviderKey: InjectionKey {
    public static var currentValue: MovieListUseCase = ImpMovieListUseCase()
}

extension InjectedValue {
    public var movieListRepo: MovieListRepository {
        get { Self[MovieListRepoProviderKey.self] }
        set { Self[MovieListRepoProviderKey.self] = newValue }
    }
    public var movieListUC: MovieListUseCase {
        get { Self[MovieListUcProviderKey.self] }
        set { Self[MovieListUcProviderKey.self] = newValue }
    }
}

