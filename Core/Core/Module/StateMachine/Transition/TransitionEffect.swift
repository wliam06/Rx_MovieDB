//
//  TransitionEffect.swift
//  Core
//
//  Created by William on 18/07/22.
//

import Foundation

/// used to handling transition with side effect
public struct TransitionEffect<State: StateType, Effect: SideEffect> {
    /// destination state
    public let state: State
    /// side effect
    public let sideEffect: Effect?

    public init(
        toState state: State,
        sideEffect: Effect? = nil
    ) {
        self.state = state
        self.sideEffect = sideEffect
    }
}
