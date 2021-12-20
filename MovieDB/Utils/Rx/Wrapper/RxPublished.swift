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
class RxPublished<Value> {
    let projectedValue: BehaviorSubject<Value>
    var wrappedValue: Value {
        get {
            try! projectedValue.value()
        }
        set {
            projectedValue.onNext(newValue)
        }
    }

    init(wrappedValue: Value) {
        self.projectedValue = BehaviorSubject<Value>(value: wrappedValue)
    }
}
