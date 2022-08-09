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

public final class MovieListModule: MovieListManageModule, MovieListRouteModule {
    public static let shared = MovieListModule()

    public func start() {
        let coordinator = MovieListCoordinator()
        coordinator.start()
    }

    public func navigateToDetail(movieId: Int) {
        ModuleManagement.shared.module(withType: MovieDetailManageModule.self)?.start(movieId: movieId)
    }
}
