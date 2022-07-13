//
//  MovieListUseCase.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxSwift
import NSObject_Rx
import Networking
import Core

protocol MovieListUseCase {
    func fetchNowPlaying(
        page: Int
    ) -> Single<MovieResultResponse>

    func fetchUpcoming(
        page: Int
    ) -> Single<MovieResultResponse>

    func fetchPopular(
        page: Int
    ) -> Single<MovieResultResponse>
}

final class ImpMovieListUseCase: MovieListUseCase, HasDisposeBag {
    @Injected(\.movieListRepo) var repository: MovieListRepository

    func fetchNowPlaying(page: Int) -> Single<MovieResultResponse> {
        repository.getNowPlaying(page: page)
    }

    func fetchUpcoming(page: Int) -> Single<MovieResultResponse> {
        repository.getUpcoming(page: page)
    }

    func fetchPopular(page: Int) -> Single<MovieResultResponse> {
        repository.getPopular(page: page)
    }
}
