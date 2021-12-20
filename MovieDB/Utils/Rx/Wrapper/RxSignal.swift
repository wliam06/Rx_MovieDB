//
//  RxSignal.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation
import RxSwift

@propertyWrapper
class RxSignal<Value> {
    private var relay = PublishSubject<Value>()

    var wrappedValue: Observable<Value>
    var projectedValue: AnyObserver<Value>

    init() {
        projectedValue = .init(relay)
        wrappedValue = relay.asObservable()
    }
}

/**
 How to use:
 @RxSignal var isLoading: Observable<Bool> = false
 */
