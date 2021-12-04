//
//  RxObserve.swift
//  MovieDB
//
//  Created by William on 20/08/21.
//

import RxSwift

/// Observe from controller to viewmodel
@propertyWrapper
class RxTrigger<Value> {

    private var relay = PublishSubject<Value>()
    
    var wrappedValue: AnyObserver<Value>
    var projectedValue: Observable<Value>
    
    init() {
        wrappedValue = .init(relay)
        projectedValue = relay.asObservable()
    }
    
}

/// Receive from viewmodel to controller
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
