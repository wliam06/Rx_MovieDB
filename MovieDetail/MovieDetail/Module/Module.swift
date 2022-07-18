//
//  Module.swift
//  MovieDetail
//
//  Created by William on 17/07/22.
//

import Foundation

public class MovieDetailModule {
    private static let shared = MovieDetailModule()

    public static func configure(movieId: Int) {
        self.shared.instance(id: movieId)
    }

    private func instance(id: Int) {
        let coordinator = MovieDetailCoordinator(id: id)
        coordinator.start()
    }
}
