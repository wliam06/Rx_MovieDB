//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation
import RxSwift
import NSObject_Rx

class ImpMovieListViewModel: HasDisposeBag {
    // Input
    @RxPublished var page: Int = 1
    @RxPublished var isLoading: Bool = false
    @RxPublished var nowPlaying = [MovieResponse]()
    @RxPublished var popular = [MovieResponse]()
    @RxPublished var upcoming = [MovieResponse]()

    @RxPublished var isNowPlayingLoading = true
    @RxPublished var isPopularLoading = true
    @RxPublished var isUpcomingLoading = true

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

    func didSelectMovie(movie: MovieResponse) {
        self.router.navigateTo(route: .detail(id: movie.id))
    }
}
