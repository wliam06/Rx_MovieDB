//
//  MovieRepository.swift
//  MovieDB
//
//  Created by William on 14/11/21.
//

import RxSwift
import Alamofire

protocol MovieRepository: AnyObject {
    func getUpcoming(page: Int) -> Observable<MovieResultResponse>
}

final class ImpMovieRepository: MovieRepository {
    private var networkRequest: NetworkRequest
    let dispose = DisposeBag()

    init(networkRequest: NetworkRequest) {
        self.networkRequest = networkRequest
    }

    func getUpcoming(page: Int) -> Observable<MovieResultResponse> {
        return self.networkRequest.request(
            MovieEndpoint.getUpcoming(page: 1),
            decodable: MovieResultResponse.self
        ).runInThread().asObservable()
    }
}
