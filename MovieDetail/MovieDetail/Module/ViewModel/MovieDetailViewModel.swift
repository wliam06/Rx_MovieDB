//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by William on 21/12/21.
//

import MovieKit
import RxFramework
import Core

final class MovieDetailViewModel: ParentViewModel {
    @RxPublished var movie = [MovieDetailModel]()

    @Injected(\.movieDetailUC) var usecase: MovieDetailUseCase
    
    private(set) var movieId: Int

    init(_ movieId: Int) {
        self.movieId = movieId
    }

    override func didLoad() {
        super.didLoad()

        usecase
            .fetchMovieDetail(id: movieId)
            .subscribe(onSuccess: { [weak self] in
                self?.movie.append($0)
            }).disposed(by: disposeBag)
    }

    override func didDisappear() {
        super.didDisappear()

        self.movie.removeAll()
    }
}
