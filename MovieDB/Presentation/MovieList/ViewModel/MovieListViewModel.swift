//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation
import RxSwift
import NSObject_Rx

final class ImpMovieListViewModel: MovieListViewModel, HasDisposeBag {
    // Input
    @RxPublished var page: Int = 1
    @RxPublished var isLoading: Bool = false
    @RxPublished var movies: [MovieResponse] = []
//    @RxPublished var movies: MovieListModel? = nil

    // Output
    var currentPage: BehaviorSubject<Int>.Observer { $page }
    var activityLoading: BehaviorSubject<Bool>.Observer { $isLoading }
    var moviesResult: BehaviorSubject<[MovieResponse]>.Observer { $movies }
//    var moviesResult: BehaviorSubject<MovieListModel?>.Observer { $movies }

    private let usecase: MovieListUseCase
    private let router: Router<MovieListRoute>

    init(router: Router<MovieListRoute>, usecase: MovieListUseCase) {
        self.router = router
        self.usecase = usecase

        initialLoad()
    }

    private func initialLoad() {
        self.isLoading = true

        usecase.fetchNowPlaying(page: page).subscribe(onSuccess: { [weak self] in
            self?.isLoading = false
            self?.movies = $0.results
        }).disposed(by: disposeBag)

//        _ = Single.zip(
//            usecase.fetchNowPlaying(page: 1),
//            usecase.fetchPopular(page: 1),
//            usecase.fetchUpcoming(page: 1)
//        ).do(onSuccess: { [weak self] result in
//            self?.movies?.nowPlaying = result.0.results
//            self?.movies?.popular = result.1.results
//            self?.movies?.upcoming = result.2.results
//        })
    }

    func didSelectMovie() {
        self.router.navigateTo(route: .detail)
    }
}
