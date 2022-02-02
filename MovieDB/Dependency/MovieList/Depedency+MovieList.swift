//
//  Depedency+MovieList.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation

extension Dependency {
    func registerMovieList() {
        registerMovieListRepository()
        registerMovieListUsecase()
    }

    func registerMovieListRepository() {
        register(type: MovieListRepository.self) { (container) -> AnyObject in
            return ImpMovieListRepository(
                networkRequest: container.resolve(type: NetworkRequest.self)
            )
        }
    }

    func registerMovieListUsecase() {
        register(type: MovieListUseCase.self) { (container) -> AnyObject in
            return ImpMovieListUseCase(
                repository: container.resolve(type: MovieListRepository.self)
            )
        }
    }
}
