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
        static func == (lhs: MovieListViewModel.State, rhs: MovieListViewModel.State) -> Bool {
            return true
        }
        
        case isLoading
        case error
        case successLoadNowPlaying([MovieResponse])
        case successLoadPopular([MovieResponse])
        case successLoadUpcoming([MovieResponse])


        var nowPlaying: [MovieResponse] {
            switch self {
            case .successLoadNowPlaying(let movie):
                return movie
            default:
                return []
            }
        }
        var popular: [MovieResponse] {
            switch self {
            case .successLoadPopular(let movie):
                return movie
            default:
                return []
            }
        }
        var upcoming: [MovieResponse] {
            switch self {
            case .successLoadUpcoming(let movie):
                return movie
            default:
                return []
            }
        }

        static func routes(fromState state: State, fromEvent event: Event)  -> TransitionEffect<State, Effect>? {
            switch (state, event) {
            case (.isLoading, .didRequest):
                return TransitionEffect(toState: .isLoading, sideEffect: .onShowSkeleton)
            case (.isLoading, .didReceiveError):
                return TransitionEffect(toState: .error)
            case (.isLoading, .didSuccessLoadNowPlaying(let movies)):
                return TransitionEffect(toState: .successLoadNowPlaying(movies), sideEffect: .onHideSkeleton)
            case (.isLoading, .didSuccessLoadPopular(let movies)):
                return TransitionEffect(toState: .successLoadPopular(movies), sideEffect: .onHideSkeleton)
            case (.isLoading, .didSuccessUpcoming(let movies)):
                return TransitionEffect(toState: .successLoadUpcoming(movies), sideEffect: .onHideSkeleton)
            case (.successLoadNowPlaying(let movies), .didMovieDetail(let movie)):
                return TransitionEffect(toState: .successLoadNowPlaying(movies), sideEffect: .onTapDetail(movie))
            case (.successLoadPopular(let movies), .didMovieDetail(let movie)):
                return TransitionEffect(toState: .successLoadPopular(movies), sideEffect: .onTapDetail(movie))
            case (.successLoadUpcoming(let movies), .didMovieDetail(let movie)):
                return TransitionEffect(toState: .successLoadUpcoming(movies), sideEffect: .onTapDetail(movie))
            default:
                return nil
            }
        }
    }

    enum Event:EventType {
        case didRequest
        case didMovieDetail(MovieResponse)
        case didReceiveError
        case didSuccessLoadNowPlaying([MovieResponse])
        case didSuccessLoadPopular([MovieResponse])
        case didSuccessUpcoming([MovieResponse])
    }

    enum Effect: SideEffect {
        case onShowSkeleton
        case onHideSkeleton
        case onTapDetail(MovieResponse)
    }
}

final class MovieListViewModel: ParentViewModel, StateMachineBuilder {
    // Input
    @RxPublished var page: Int = 1
    @RxPublished var nowPlaying = [MovieResponse]()
    @RxPublished var popular = [MovieResponse]()
    @RxPublished var upcoming = [MovieResponse]()

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
        default:
            return
        }
    }

    // MARK: - ViewController Lifecycle
    override func didLoad() {
        super.didLoad()

//        self.viewState = .loading
        self.stateMachine.transition(.didRequest)
        Single.zip(
            usecase.fetchNowPlaying(page: page),
            usecase.fetchPopular(page: page),
            usecase.fetchUpcoming(page: page)
        ).subscribe(onSuccess: { [weak self] (nowPlaying, popular, upcoming) in
//            self?.stateMachine.transition(.didSuccessLoadNowPlaying(.just(nowPlaying.results)))
//            self?.stateMachine.transition(.didSuccessUpcoming(.just(upcoming.results)))
//            self?.stateMachine.transition(.didSuccessLoadPopular(.just(popular.results)))
            self?.stateMachine.transition(.didSuccessLoadNowPlaying(nowPlaying.results))
            self?.stateMachine.transition(.didSuccessUpcoming(upcoming.results))
            self?.stateMachine.transition(.didSuccessLoadPopular(popular.results))
        }).disposed(by: disposeBag)
    }

    func didSelectMovie(movie: MovieResponse) {
        self.router.navigateTo(route: .detail(id: movie.id))
    }
}
