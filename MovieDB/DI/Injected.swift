//
//  Injected.swift
//  MovieDB
//
//  Created by William on 02/02/22.
//

import Foundation

public protocol InjectionKey {
    /// Represent the type of dependency injection key's value
    associatedtype Value

    /// The default value for the dependency injection key
    static var currentValue: Self.Value { get set }
}

/// Provides access to injected dependencies.
struct InjectedValue {
    /// Only used as an accessor to the computed properties within extensions of `InjectedValue`.
    private static var current = InjectedValue()

    /// Updating the `currentValue` of `InjectionKey` instances.
    static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue}
    }

    /// Update and references dependencies directly.
    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValue, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

@propertyWrapper
struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectedValue, T>
    var wrappedValue: T {
        get { InjectedValue[keyPath] }
        set { InjectedValue[keyPath] = newValue }
    }

    init(_ keyPath: WritableKeyPath<InjectedValue, T>) {
        self.keyPath = keyPath
    }
}

/**
 ex:
 protocol A {}
 struct SampleA: A {}
 
 struct Loader {
    @Injected(\.a) var protocolA: A
 }
 */
