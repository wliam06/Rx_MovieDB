//
//  MovieDetailUseCase.swift
//  MovieDB
//
//  Created by William on 28/02/22.
//

import RxSwift
import NSObject_Rx

protocol MovieDetailUseCase: AnyObject {
    func fetchMovieDetail(id: Int) -> Single<MovieDetailResponse>
}

final class ImpMovieDetailUseCase: MovieDetailUseCase {
    @Injected(\.movieDetailRepo) var repository: MovieDetailRepository

    func fetchMovieDetail(id: Int) -> Single<MovieDetailResponse> {
        repository.getMovieDetail(id)
    }
}
