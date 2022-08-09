//
//  Module.swift
//  MovieList
//
//  Created by William on 17/07/22.
//

import ModuleManagement

public protocol MovieListRouteModule {
    func navigateToDetail(movieId: Int)
}

public struct MovieListModule: MovieListManageModule, MovieListRouteModule {
    public func start() {
        let coordinator = MovieListCoordinator()
        coordinator.start()
    }

    public func navigateToDetail(movieId: Int) {
        ModuleManagement.shared.module(withType: MovieDetailManageModule.self)?.start(movieId: movieId)
    }
}
