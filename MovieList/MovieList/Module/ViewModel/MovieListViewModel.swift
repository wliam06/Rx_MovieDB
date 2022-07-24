//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxFramework
import Core
import MovieKit
import Networking

class MovieListViewModel: ParentViewModel, StateMachineBuilder {
    // Input
    @RxPublished var page: Int = 1

    private let router: Router<MovieListRoute>

    @Injected(\.movieListUC) var usecase: MovieListUseCase

    lazy var stateMachine = StateMachine<State, Event, Effect>(
        initialState: .isLoading,
        routing: State.routes,
        effects: { [weak self] in
            self?.effectHandler(effect: $0)
        }
    )

    init(router: Router<MovieListRoute>) {
        self.router = router
        super.init()
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
        default:
            return
        }
    }

    // MARK: - ViewController Lifecycle
    override func didLoad() {
        super.didLoad()
        self.stateMachine.transition(.didRequest)
        Single.zip(
            usecase.fetchNowPlaying(page: page),
            usecase.fetchPopular(page: page),
            usecase.fetchUpcoming(page: page)
        ).subscribe(onSuccess: { [weak self] (nowPlaying, popular, upcoming) in
            self?.stateMachine.transition(
                .didSuccessLoadMovies(
                    nowPlaying.results,
                    upcoming.results,
                    popular.results
                )
            )
        }).disposed(by: disposeBag)
    }

    func navigateToDetail(movie: MovieResponse) {
        self.router.navigateTo(route: .detail(id: movie.id))
    }
}
