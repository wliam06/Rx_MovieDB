//
//  Module.swift
//  MovieList
//
//  Created by William on 17/07/22.
//

import Foundation

public class MovieListModule {
    private static let shared = MovieListModule()

    public static func configure() {
        self.shared.instance()
    }

    private func instance() {
        let coordinator = MovieListCoordinator()
        coordinator.start()
    }
}
