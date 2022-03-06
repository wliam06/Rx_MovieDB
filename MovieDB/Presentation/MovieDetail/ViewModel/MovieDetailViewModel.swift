//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by William on 21/12/21.
//

import Foundation
import RxSwift
import NSObject_Rx

final class MovieDetailViewModel: HasDisposeBag {
    @RxPublished var movie = [MovieDetailResponse]()

    @Injected(\.movieDetailUC) var usecase: MovieDetailUseCase
    
    private(set) var movieId: Int

    init(_ movieId: Int) {
        self.movieId = movieId

        initialLoad()
    }

    private func initialLoad() {
        usecase
            .fetchMovieDetail(id: movieId)
            .subscribe(onSuccess: {
//                self.movie = $0
                self.movie.append($0)
            }).disposed(by: disposeBag)
    }
}
