//
//  MovieRepository.swift
//  MovieDB
//
//  Created by William on 14/11/21.
//

import RxSwift
import Alamofire

protocol MovieRepository: AnyObject {
//    func getUpcoming(page: Int) -> Single<MovieResultResponse>
    func getUpcoming(page: Int) -> Observable<MovieResultResponse>
}

final class ImpMovieRepository: MovieRepository {
    private var networkRequest: NetworkRequest
    let dispose = DisposeBag()

    init(networkRequest: NetworkRequest) {
        self.networkRequest = networkRequest
    }

    func getUpcoming(page: Int) -> Observable<MovieResultResponse> {
//        networkRequest.request(
//           MovieEndpoint.getUpcoming(page: 1),
//           decodable: MovieResultResponse.self
//        ).runInThread().subscribe(onSuccess: {
//            print("success", $0)
//        }, onFailure: {
//            print("ERROR", $0)
//        }).disposed(by: dispose)

        return self.networkRequest.request(
            MovieEndpoint.getUpcoming(page: 1),
            decodable: MovieResultResponse.self
        ).runInThread().asObservable()
    }
}
