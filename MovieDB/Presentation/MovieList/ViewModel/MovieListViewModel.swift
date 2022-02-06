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
    @RxPublished var nowPlaying = [MovieResponse]()
    @RxPublished var popular = [MovieResponse]()
    @RxPublished var upcoming = [MovieResponse]()

    @RxPublished var isNowPlayingLoading = true
    @RxPublished var isPopularLoading = true
    @RxPublished var isUpcomingLoading = true

    // Output
    var currentPage: BehaviorSubject<Int>.Observer { $page }
    var activityLoading: BehaviorSubject<Bool>.Observer { $isLoading }

    var nowPlayingResult: BehaviorSubject<[MovieResponse]>.Observer { $nowPlaying }
    var nowPlayingLoaded: BehaviorSubject<Bool>.Observer { $isNowPlayingLoading }

    var upcomingResult: BehaviorSubject<[MovieResponse]>.Observer { $upcoming }
    var upcomingLoaded: BehaviorSubject<Bool>.Observer { $isPopularLoading }

    var popularResult: BehaviorSubject<[MovieResponse]>.Observer { $popular }
    var popularLoaded: BehaviorSubject<Bool>.Observer { $isUpcomingLoading }

    private let router: Router<MovieListRoute>

    @Injected(\.movieListUC) var usecase: MovieListUseCase

    init(router: Router<MovieListRoute>) {
        self.router = router

        initialLoad()
    }

    private func initialLoad() {
        self.isLoading = true
        
        Single.zip(
            usecase.fetchNowPlaying(page: page),
            usecase.fetchPopular(page: page),
            usecase.fetchUpcoming(page: page)
        ).subscribe(onSuccess: { [weak self] (nowPlaying, popular, upcoming) in
            self?.isLoading = false
            self?.nowPlaying = nowPlaying.results
            self?.popular = popular.results
            self?.upcoming = upcoming.results
        }).disposed(by: disposeBag)
    }

    func didSelectMovie() {
        self.router.navigateTo(route: .detail)
    }
}
