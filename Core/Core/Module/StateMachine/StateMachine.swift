//
//  StateMachine.swift
//  Core
//
//  Created by William on 18/07/22.
//

import RxFramework
import UIKit

public protocol StateType: Equatable {}
public protocol EventType {}
public protocol SideEffect {}

public protocol StateMachineBuilder {
    associatedtype State: StateType
    associatedtype Event: EventType
    associatedtype Effect: SideEffect

    var stateMachine: StateMachine<State, Event, Effect> { get }
    func effectHandler(effect: Effect?)
}

public class StateMachine<State: StateType, Event: EventType, Effect: SideEffect> {

    /// will emit every time state changes
    @RxPublished public private(set) var currentState: State
    /// will emit after execute `sideEffectTrigger`
    @RxPublished public private(set) var transitionResult: TransitionResultState<State, Event>?
    ///  execute side effect
    @RxTrigger private var sideEffectTrigger: AnyObserver<Void>

    private lazy var disposeBag = DisposeBag()
    private var prevState: State?
    private var event: Event?

    /// routing set next state by current state and event
    private let routing: (State, Event) -> TransitionEffect<State, Effect>?
    /// to handling side effect
    private let effects: (Effect?) -> Void

    ///
    private var initialState: State

    /// Params
    ///  - `initialState`: identify initial state
    ///  - `routing`: register all routes
    ///  - `effects`: to execute side effect every transition from state A to B
    public init(
        initialState: State,
        routing: @escaping (State, Event) -> TransitionEffect<State, Effect>?,
        effects: @escaping (Effect?) -> Void
    ) {
        self.initialState = initialState
        self.currentState = self.initialState
        self.routing = routing
        self.effects = effects

        self.observeEffect()
    }

    public func transition(
        _ event: Event
    ) {
        guard let next = self.routing(currentState, event) else {
            transitionResult = .failure(error:
                    .init(
                        currentState: currentState,
                        error: .noRoute,
                        event: event
                    )
            )
            return
        }

        self.prevState = currentState
        self.currentState = next.state
        self.event = event
        sideEffectTrigger.onNext(self.effects(next.sideEffect))
    }

    private func observeEffect() {
        $sideEffectTrigger.subscribe(onNext: { [weak self] _ in
            guard let `self` = self,
                  let prevState = self.prevState,
                  let event = self.event else { return }
            self.transitionResult = .success(
                prev: prevState,
                new: self.currentState,
                event: event
            )
        }).disposed(by: disposeBag)
    }

    public func onTransitionResult(
        onSuccess: ((State, State, Event) -> Void)? = nil,
        onFailure: ((StateTransitionError<State, Event>) -> Void)? = nil
    ) {
        switch self.transitionResult {
        case .success(let prev, let new, let event):
            onSuccess?(prev, new, event)
        case .failure(let error):
            onFailure?(error)
        default:
            return
        }
    }
}
