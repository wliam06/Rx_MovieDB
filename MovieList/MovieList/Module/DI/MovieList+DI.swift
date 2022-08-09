//
//  MovieList+DI.swift
//  MovieList
//
//  Created by William on 09/08/22.
//

import Core
import ModuleManagement

// MARK: - MovieDetail Repo

private struct MovieListModuleProviderKey: InjectionKey {
    static var currentValue: MovieListRouteModule = MovieListModule.shared
}

extension InjectedValue {
    public var movieListModule: MovieListRouteModule {
        get { Self[MovieListModuleProviderKey.self] }
        set { Self[MovieListModuleProviderKey.self] = newValue }
    }
}
