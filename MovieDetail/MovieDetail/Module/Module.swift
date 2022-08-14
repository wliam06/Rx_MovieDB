//
//  Module.swift
//  MovieDetail
//
//  Created by William on 17/07/22.
//

import ModuleManagement

public final class MovieDetailModule: MovieDetailManageModule {
    public static let shared = MovieDetailModule()
    public func start(movieId: Int?) {
        guard let id = movieId else { return }
        let coordinator = MovieDetailCoordinator(id: id)
        coordinator.start()
    }
}
