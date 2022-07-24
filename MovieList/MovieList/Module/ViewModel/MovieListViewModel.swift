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

extension MovieListViewModel {
    enum State: StateType {
        case isLoading
        case error
        case doRoute
        case successLoadMovies([MovieResponse], [MovieResponse], [MovieResponse])

        var nowPlaying: [MovieResponse] {
            switch self {
            case .successLoadMovies(let movie, _, _):
                return movie
            default:
                return []
            }
        }
        var popular: [MovieResponse] {
            switch self {
            case .successLoadMovies(_, let movie, _):
                return movie
            default:
                return []
            }
        }
        var upcoming: [MovieResponse] {
            switch self {
            case .successLoadMovies(_, _, let movie):
                return movie
            default:
                return []
            }
        }

        static func routes(fromState state: State, fromEvent event: Event)  -> TransitionEffect<State, Effect>? {
            switch (state, event) {
            case (.isLoading, .viewDidLoad):
                return TransitionEffect(toState: .isLoading, sideEffect: .onViewDidLoad)
            case (.isLoading, .didRequest):
                return TransitionEffect(toState: .isLoading, sideEffect: .onShowSkeleton)
            case (.isLoading, .didReceiveError):
                return TransitionEffect(toState: .error)
            case (.isLoading, .didSuccessLoadMovies(let nowPlaying, let popular, let upcoming)):
                return TransitionEffect(toState: .successLoadMovies(nowPlaying, popular, upcoming), sideEffect: .onHideSkeleton)
            case (.doRoute, .didMovieDetail(let movie)):
                return TransitionEffect(toState: .isLoading, sideEffect: .onTapDetail(movie))
            case (.successLoadMovies, .didMovieDetail(let movie)):
                return TransitionEffect(toState: .doRoute, sideEffect: .onTapDetail(movie))
            default:
                return nil
            }
        }
    }

    enum Event: EventType {
        case viewDidLoad
        case didRequest
        case didMovieDetail(MovieResponse)
        case didReceiveError
        case didSuccessLoadMovies([MovieResponse], [MovieResponse], [MovieResponse])
    }

    enum Effect: SideEffect {
        case onViewDidLoad
        case onShowSkeleton
        case onHideSkeleton
        case onTapDetail(MovieResponse)
    }
}

final class MovieListViewModel: ParentViewModel, StateMachineBuilder {
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
        case .onTapDetail(let movie):
            print("onTapDetail")
//            self.stateMachine.transition(.didMovieDetail(movie))
            self.router.navigateTo(route: .detail(id: movie.id))
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
}
