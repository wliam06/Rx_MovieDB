//
//  MovieListUseCase.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxSwift
import NSObject_Rx

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
//    private let repository: MovieListRepository
//
//    init(repository: MovieListRepository) {
//        self.repository = repository
//    }

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
