//
//  GetNowPlayingUseCase.swift
//  MovieDB
//
//  Created by William on 27/08/21.
//

import Foundation
import RxSwift
import NSObject_Rx

protocol HomeUsecase {
//    func fetchNowPlaying(page: Int) -> Single<MovieResultResponse>
    func fetchNowPlaying(page: Int, completion: @escaping (Result<MovieResultResponse, Error>) -> Void)
}

final class ImpHomeUsecase: HomeUsecase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func fetchNowPlaying(
        page: Int,
        completion: @escaping (Result<MovieResultResponse, Error>) -> Void
    ) {
        repository.getUpcoming(page: page).subscribe(onNext: {
            completion(.success($0))
        }, onError: {
            completion(.failure($0))
        })
    }
}
