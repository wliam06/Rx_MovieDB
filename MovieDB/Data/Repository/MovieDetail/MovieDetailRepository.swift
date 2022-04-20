//
//  MovieDetailRepository.swift
//  MovieDB
//
//  Created by William on 28/02/22.
//

import RxSwift
import Alamofire

protocol MovieDetailRepository: AnyObject {
    func getMovieDetail(_ id: Int) -> Single<MovieDetailResponse>
}

class ImpMovieDetailRepository: MovieDetailRepository {
    @Injected(\.networkRequest) var network: NetworkRequest

    func getMovieDetail(_ id: Int) -> Single<MovieDetailResponse> {
        return self.network.request(
            MovieEndpoint.getDetail(id: id),
            decodable: MovieDetailResponse.self
        )
    }
}
