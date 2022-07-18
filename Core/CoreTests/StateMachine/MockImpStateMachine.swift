//
//  MockImpStateMachine.swift
//  CoreTests
//
//  Created by William on 18/07/22.
//

import XCTest
@testable import Core

protocol ImpStateMachineType: StateMachineBuilder {
    func onRequestAPI(id: String?)
}

final class MockImpStateMachine: ImpStateMachineType {

    

    enum State: StateType {
        case starting
        case request
        case cancel
        case stop

        static func routes(fromState: State, event: Event) -> TransitionEffect<State, Effect>? {
            switch (fromState, event) {
            case (.request, .didLoading(let id)):
                return TransitionEffect(toState: .request, sideEffect: .onRequest(id))
            case (.request, .didSuccess(let id)):
                return TransitionEffect(toState: .stop, sideEffect: .onRequest(id))
            case (.starting, .didLoading(_)):
                return TransitionEffect(toState: .starting)
            case (.cancel, .didLoading(_)):
                return TransitionEffect(toState: .cancel)
            default:
                return nil
            }
        }
    }

    enum Event: EventType {
        case didLoading(String)
        case didSuccess(String)
        case didFailure
    }

    enum Effect: SideEffect {
        case onRequest(String)
    }

    var invokedStateMachineGetter = false
    var invokedStateMachineGetterCount = 0
    var stubbedStateMachine: StateMachine<State, Event, Effect>!

    var stateMachine: StateMachine<State, Event, Effect> {
        invokedStateMachineGetter = true
        invokedStateMachineGetterCount += 1
        return stubbedStateMachine
    }

    var invokedOnRequestAPI = false
    var invokedOnRequestAPICount = 0
    var invokedOnRequestAPIParameters: (id: String?, Void)?
    var invokedOnRequestAPIParametersList = [(id: String?, Void)]()

    func onRequestAPI(id: String?) {
        invokedOnRequestAPI = true
        invokedOnRequestAPICount += 1
        invokedOnRequestAPIParameters = (id, ())
        invokedOnRequestAPIParametersList.append((id, ()))
    }

    var invokedEffectHandler = false
    var invokedEffectHandlerCount = 0
    var invokedEffectHandlerParameters: (effect: Effect?, Void)?
    var invokedEffectHandlerParametersList = [(effect: Effect?, Void)]()

    func effectHandler(effect: Effect?) {
        invokedEffectHandler = true
        invokedEffectHandlerCount += 1
        invokedEffectHandlerParameters = (effect, ())
        invokedEffectHandlerParametersList.append((effect, ()))
    }
}


//    enum State: StateType {
//        case starting
//        case request
//        case cancel
//
//        static func routes(fromState: State, event: Event) -> TransitionEffect<State, Effect>? {
//            switch (fromState, event) {
//            case (.request, .didLoading(let id)):
//                return TransitionEffect(toState: .request, sideEffect: .onRequest(id))
//            case (.starting, .didLoading(_)):
//                return TransitionEffect(toState: .starting)
//            case (.cancel, .didLoading(_)):
//                return TransitionEffect(toState: .cancel)
//            default:
//                return nil
//            }
//        }
//    }
//
//    enum Event: EventType {
//        case didLoading(String)
//        case didSuccess(String)
//        case didFailure
//    }
//
//    enum Effect: SideEffect {
//        case onRequest(String)
//    }
//
//    lazy var stateMachine = StateMachine<State, Event, Effect>(
//        initialState: .cancel,
//        routing: MockImpStateMachine.State.routes,
//        effects: { [weak self] in
//            self?.effectHandler(effect: $0)
//        }
//    )
//
//    func onRequestAPI(id: String) {
//        self.stateMachine.transition(.didSuccess("success with \(id)"))
//    }
//
//    func effectHandler(effect: Effect?) {
//        switch effect {
//        case .onRequest(let id):
//            self.onRequestAPI(id: id)
//        default:
//            return
//        }
//    }
