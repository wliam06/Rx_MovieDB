//
//  TransitionResult.swift
//  Core
//
//  Created by William on 18/07/22.
//

import Foundation

public enum StateMachineError: Error {
    case noRoute
}

// used to get transition result
public enum TransitionResultState<S: StateType, E: EventType> {
    // on Success will return previous state, new state, and the event
    case success(prev: S, new: S, event: E)
    // on Failure will return transition error
    case failure(error: StateTransitionError<S, E>)
}

// used to handle transition error
public struct StateTransitionError<S: StateType, E: EventType>: Error {
    public let currentState: S
    public let error: StateMachineError
    public let event: E
}
