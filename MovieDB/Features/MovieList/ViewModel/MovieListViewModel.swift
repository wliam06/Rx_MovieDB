//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation
import RxSwift

class ImpMovieListViewModel: ParentViewModel {
    // Input
    @RxPublished var page: Int = 1
    @RxPublished var nowPlaying = [MovieResponse]()
    @RxPublished var popular = [MovieResponse]()
    @RxPublished var upcoming = [MovieResponse]()

    private let router: Router<MovieListRoute>

    @Injected(\.movieListUC) var usecase: MovieListUseCase

    init(router: Router<MovieListRoute>) {
        self.router = router
        super.init()
    }

    // MARK: - ViewController Lifecycle
    override func didLoad() {
        super.didLoad()

        self.viewState = .loading
        Single.zip(
            usecase.fetchNowPlaying(page: page),
            usecase.fetchPopular(page: page),
            usecase.fetchUpcoming(page: page)
        ).subscribe(onSuccess: { [weak self] (nowPlaying, popular, upcoming) in
            self?.viewState = .finish
            self?.nowPlaying = nowPlaying.results
            self?.popular = popular.results
            self?.upcoming = upcoming.results
        }).disposed(by: disposeBag)
    }

    func didSelectMovie(movie: MovieResponse) {
        self.router.navigateTo(route: .detail(id: movie.id))
    }
}
