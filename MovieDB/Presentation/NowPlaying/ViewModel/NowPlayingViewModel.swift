//
//  NowPlayingViewModel.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation
import RxSwift
import NSObject_Rx

final class ImpNowPlayingViewModel: NowPlayingViewModel, HasDisposeBag {
    // Input
    @RxPublished var page: Int = 1
    @RxPublished var isLoading: Bool = false
    @RxPublished var movies: [MovieResponse] = []

    // Output
    var currentPage: BehaviorSubject<Int>.Observer { $page }
    var activityLoading: BehaviorSubject<Bool>.Observer { $isLoading }
    var moviesResult: BehaviorSubject<[MovieResponse]>.Observer { $movies }

    private let usecase: MovieListUseCase

    init(usecase: MovieListUseCase) {
        self.usecase = usecase

        initialLoad()
    }

    private func initialLoad() {
        self.isLoading = true
        usecase.fetchNowPlaying(page: page).subscribe(onNext: { [weak self] in
            self?.isLoading = false
            self?.movies = $0.results
        }).disposed(by: disposeBag)
    }
}
