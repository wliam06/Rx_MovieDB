//
//  Injected.swift
//  MovieDB
//
//  Created by William on 02/02/22.
//

import Foundation

/**
 how to use Injection:
 protocol A {}
 struct SampleA: A {}
 
 struct Loader {
    @Injected(\.a) var protocolA: A
 }
 */

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
 how to use Weak Injection:
 
 protocol A: AnyObject {}
 struct SampleA: A {}
 
 struct Loader {
    @InjectedWeak(\.a) var protocolA // will be optional
 }
 
 struct SampleAWeakKey: InjectedWeakKey {
     static weak var currentValue: A?
 }
 extension InjectionWeakValue {
      var a: SampleA? {
        get {} set {}
      }
 }
 */

/// Provides weak references for retaining cycles
public protocol InjectionWeakKey {
    associatedtype Value
    static var currentValue: Self.Value? { get set }
}


/// Provides access to injected weak dependencies.
struct InjectedWeakValue {
    /// Only used as an accessor to the computed properties within extensions of `InjectedValue`.
    private static var current = InjectedWeakValue()

    /// Updating the `currentValue` of `InjectionKey` instances.
    static subscript<K>(key: K.Type) -> K.Value? where K: InjectionWeakKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }

    /// Update and references dependencies directly.
    static subscript<T>(_ keyPath: WritableKeyPath<InjectedWeakValue, T?>) -> T? {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}


@propertyWrapper
struct InjectedWeak<T> {
    private let keyPath: WritableKeyPath<InjectedWeakValue, T?>
    var wrappedValue: T? {
        get { InjectedWeakValue[keyPath] }
        set { InjectedWeakValue[keyPath] = newValue }
    }

    init(_ keyPath: WritableKeyPath<InjectedWeakValue, T?>) {
        self.keyPath = keyPath
    }
}
