//
//  MovieListRepository.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxSwift
import Networking

protocol MovieListRepository: AnyObject {
    func getUpcoming(page: Int) -> Single<MovieResultResponse>
    func getNowPlaying(page: Int) -> Single<MovieResultResponse>
    func getPopular(page: Int) -> Single<MovieResultResponse>
}

final class ImpMovieListRepository: MovieListRepository {
    @Injected(\.networkRequest) var network: NetworkRequest
    let dispose = DisposeBag()

    func getUpcoming(page: Int) -> Single<MovieResultResponse> {
        return self.network.request(
            MovieEndpoint.getUpcoming(page: page),
            decodable: MovieResultResponse.self
        )
    }

    func getNowPlaying(page: Int) -> Single<MovieResultResponse> {
        return self.network.request(
            MovieEndpoint.getNowPlaying(page: page),
            decodable: MovieResultResponse.self
        )
    }

    func getPopular(page: Int) -> Single<MovieResultResponse> {
        return self.network.request(
            MovieEndpoint.getPopular(page: page),
            decodable: MovieResultResponse.self
        )
    }
}
