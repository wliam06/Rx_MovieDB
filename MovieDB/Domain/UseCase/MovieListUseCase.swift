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
    ) -> Observable<MovieResultResponse>

    func fetchUpcoming(
        page: Int
    ) -> Observable<MovieResultResponse>

    func fetchPopular(
        page: Int
    ) -> Observable<MovieResultResponse>
}

final class ImpMovieListUseCase: MovieListUseCase, HasDisposeBag {
    private let repository: MovieListRepository

    init(repository: MovieListRepository) {
        self.repository = repository
    }

    func fetchNowPlaying(page: Int) -> Observable<MovieResultResponse> {
        repository.getNowPlaying(page: page).asObservable()
    }

    func fetchUpcoming(page: Int) -> Observable<MovieResultResponse> {
        repository.getUpcoming(page: page).asObservable()
    }

    func fetchPopular(page: Int) -> Observable<MovieResultResponse> {
        repository.getPopular(page: page).asObservable()
    }
    
}
