//
//  MovieDetail+StateMachine.swift
//  MovieDetail
//
//  Created by William on 24/07/22.
//

import Core
import RxFramework

extension MovieDetailViewModel {
    enum State: StateType {
        case isLoading
        case error
        case successLoadMovie([MovieDetailModel])

        var movieDetail: [MovieDetailModel] {
            switch self {
            case .successLoadMovie(let movie):
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
            case (.isLoading, .didSuccessLoadMovies(let movie)):
                return TransitionEffect(toState: .successLoadMovie(movie), sideEffect: .onHideSkeleton)
            case (.successLoadMovie, .didClearMovie):
                return TransitionEffect(toState: .isLoading, sideEffect: .onViewDidDisappear)
            default:
                return nil
            }
        }
    }

    enum Event: EventType {
        case viewDidLoad
        case didClearMovie
        case didRequest
        case didReceiveError
        case didSuccessLoadMovies([MovieDetailModel])
    }

    enum Effect: SideEffect {
        case onViewDidLoad
        case onViewDidDisappear
        case onShowSkeleton
        case onHideSkeleton
    }
}
