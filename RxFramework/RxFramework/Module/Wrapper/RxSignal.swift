//
//  RxSignal.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation
import RxSwift

@propertyWrapper
public class RxSignal<Value> {
    private var relay = PublishSubject<Value>()

    public var wrappedValue: Observable<Value>
    public var projectedValue: AnyObserver<Value>

    public init() {
        projectedValue = .init(relay)
        wrappedValue = relay.asObservable()
    }
}

/**
 How to use:
 @RxSignal var isLoading: Observable<Bool> = false
 */
