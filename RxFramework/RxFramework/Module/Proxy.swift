//
//  Proxy.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation

//https://www.swiftbysundell.com/articles/accessing-a-swift-property-wrappers-enclosing-instance/
@propertyWrapper
struct AnyProxy<EnclosingType, Value> {
    typealias ValueKeyPath = ReferenceWritableKeyPath<EnclosingType, Value>
    typealias SelfKeyPath = ReferenceWritableKeyPath<EnclosingType, Self>

    static subscript(
        _enclosingInstance instance: EnclosingType,
        wrapped wrappedKeyPath: ValueKeyPath,
        storage storageKeyPath: SelfKeyPath
    ) -> Value {
        get {
            let keyPath = instance[keyPath: storageKeyPath].keyPath
            return instance[keyPath: keyPath]
        }
        set {
            let keyPath = instance[keyPath: storageKeyPath].keyPath
            instance[keyPath: keyPath] = newValue
        }
    }
    
    @available(*, unavailable,
                message: "@Proxy can only be applied to classes"
    )
    var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }
    
    private let keyPath: ValueKeyPath
    
    init(_ keyPath: ValueKeyPath) {
        self.keyPath = keyPath
    }
}

protocol ProxyContainer {
    typealias Proxy<T> = AnyProxy<Self, T>
}

extension NSObject: ProxyContainer {}
