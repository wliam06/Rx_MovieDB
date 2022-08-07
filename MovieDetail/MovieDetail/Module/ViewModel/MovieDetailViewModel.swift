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
    @Injected(\.movieDetailUC) var usecase: MovieDetailUseCase

    lazy var stateMachine = StateMachine<State, Event, Effect>(
        initialState: .isLoading,
        routing: State.routes,
        effects: { [weak self] in
            self?.effectHandler(effect: $0)
        }
    )

    private(set) var movieId: Int

    init(_ movieId: Int) {
        self.movieId = movieId
    }

    func effectHandler(effect: Effect?) {
        switch effect {
        case .onShowSkeleton:
            print("show skeleton")
        case .onHideSkeleton:
            print("onHideSkeleton")
        case .onViewDidLoad:
            print("ViewDidLoad")
            self.didLoad()
        case .onViewDidDisappear:
            print("onViewDidDisappear")
            self.didDisappear()
        default:
            return
        }
    }

    // MARK: - Life cycle
    override func didLoad() {
        super.didLoad()
        self.stateMachine.transition(.didRequest)

        usecase
            .fetchMovieDetail(id: movieId)
            .subscribe(onSuccess: { [weak self] in
                self?.stateMachine.transition(.didSuccessLoadMovies([$0]))
            }).disposed(by: disposeBag)
    }

    override func didDisappear() {
        super.didDisappear()

        self.stateMachine.transition(.viewDidDisappear)
    }
}
