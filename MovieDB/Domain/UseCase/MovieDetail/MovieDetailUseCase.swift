//
//  MovieDetailUseCase.swift
//  MovieDB
//
//  Created by William on 28/02/22.
//

import RxSwift
import NSObject_Rx

protocol MovieDetailUseCase: AnyObject {
    func fetchMovieDetail(id: Int) -> Single<MovieDetailModel>
}

final class ImpMovieDetailUseCase: MovieDetailUseCase {
    @Injected(\.movieDetailRepo) var repository: MovieDetailRepository

    func fetchMovieDetail(id: Int) -> Single<MovieDetailModel> {
        repository.getMovieDetail(id).map {
            return MovieDetailModel(
                title: $0.title ?? "-",
                releaseDate: $0.releaseDate ?? "-",
                overview: $0.overview ?? "-",
                movieImg: $0.getMovieImg(),
                genres: $0.genres
            )
        }
    }
}
