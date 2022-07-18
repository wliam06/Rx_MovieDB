//
//  RxTrigger.swift
//  RxFramework
//
//  Created by William on 18/07/22.
//

import Foundation
import RxSwift

@propertyWrapper
public class RxTrigger<Value> {
    private var relay = PublishSubject<Value>()

    public var wrappedValue: AnyObserver<Value>
    public var projectedValue: Observable<Value>

    public init() {
        wrappedValue = .init(relay)
        projectedValue = relay.asObservable()
    }
}
