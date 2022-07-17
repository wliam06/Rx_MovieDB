//
//  RxPublished.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxSwift

/// Wrapped value type
/// Same as Combine, @Published
@propertyWrapper
public class RxPublished<Value> {
    public let projectedValue: BehaviorSubject<Value>
    public var wrappedValue: Value {
        get {
            try! projectedValue.value()
        }
        set {
            projectedValue.onNext(newValue)
        }
    }

    public init(wrappedValue: Value) {
        self.projectedValue = BehaviorSubject<Value>(value: wrappedValue)
    }
}
