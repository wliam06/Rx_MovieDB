//
//  Container+Network.swift
//  MovieDB
//
//  Created by William on 18/09/21.
//

import Foundation

extension Container {
    func registerNetwork() {
        register(type: SessionRequest.self) { _ in
            return NetworkSession()
        }
        register(type: NetworkRequest.self) { (container) -> AnyObject in
            return NetworkSessionRequest(
                container.resolve(type: SessionRequest.self)
            )
        }
    }
}


extension Container {
    func registerHomeContainer() {
        registerMovieRepository()
        registerHomeUsecase()
    }

    func registerMovieRepository() {
        register(type: MovieRepository.self) { (container) -> AnyObject in
            return ImpMovieRepository(
                networkRequest: container.resolve(type: NetworkRequest.self)
            )
        }
    }

    func registerHomeUsecase() {
        register(type: HomeUsecase.self) { (container) -> AnyObject in
            return ImpHomeUsecase(
                repository: container.resolve(type: MovieRepository.self)
            )
        }
    }
}
