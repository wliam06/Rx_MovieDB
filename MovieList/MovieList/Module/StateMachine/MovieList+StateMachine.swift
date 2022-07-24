//
//  MovieList+StateMachine.swift
//  MovieList
//
//  Created by William on 24/07/22.
//

import Core
import Networking
import RxFramework

extension MovieListViewModel {
    enum State: StateType {
        case isLoading
        case error
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
            default:
                return nil
            }
        }
    }

    enum Event: EventType {
        case viewDidLoad
        case didRequest
        case didReceiveError
        case didSuccessLoadMovies([MovieResponse], [MovieResponse], [MovieResponse])
    }

    enum Effect: SideEffect {
        case onViewDidLoad
        case onShowSkeleton
        case onHideSkeleton
    }
}
