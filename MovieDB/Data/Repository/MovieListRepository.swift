//
//  MovieListRepository.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxSwift
import Alamofire

protocol MovieListRepository: AnyObject {
    func getUpcoming(page: Int) -> Single<MovieResultResponse>
    func getNowPlaying(page: Int) -> Single<MovieResultResponse>
    func getPopular(page: Int) -> Single<MovieResultResponse>
}

final class ImpMovieListRepository: MovieListRepository {
    private var networkRequest: NetworkRequest
    let dispose = DisposeBag()

    init(networkRequest: NetworkRequest) {
        self.networkRequest = networkRequest
    }

    func getUpcoming(page: Int) -> Single<MovieResultResponse> {
        return self.networkRequest.request(
            MovieEndpoint.getUpcoming(page: page),
            decodable: MovieResultResponse.self
        )
    }

    func getNowPlaying(page: Int) -> Single<MovieResultResponse> {
        return self.networkRequest.request(
            MovieEndpoint.getNowPlaying(page: page),
            decodable: MovieResultResponse.self
        )
    }

    func getPopular(page: Int) -> Single<MovieResultResponse> {
        return self.networkRequest.request(
            MovieEndpoint.getPopular(page: page),
            decodable: MovieResultResponse.self
        )
    }
}
