//
//  Module.swift
//  MovieDetail
//
//  Created by William on 17/07/22.
//

import ModuleManagement

public final class MovieDetailModule: MovieDetailManageModule {
    public static let shared = MovieDetailModule()
    public func start(movieId: Int) {
        let coordinator = MovieDetailCoordinator(id: movieId)
        coordinator.start()
    }
}
