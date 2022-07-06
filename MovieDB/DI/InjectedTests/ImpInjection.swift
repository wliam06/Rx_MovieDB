//
//  ImpInjection.swift
//  MovieDB
//
//  Created by William on 06/07/22.
//

import Foundation

// Regis Injection
class ImpInjectionKey: InjectionKey {
    static var currentValue: InjectionProtocol = ImpInjection()
}
extension InjectedValue {
    var strongInjection: InjectionProtocol {
        get { Self[ImpInjectionKey.self] }
        set { Self[ImpInjectionKey.self] = newValue }
    }
}

// Mock Implementation
protocol InjectionProtocol: AnyObject {
    func update(name: String)
}

final class ImpInjection: InjectionProtocol {
    var name: String?

    @Injected(\.strongInjection) var injected: InjectionProtocol

    init(name: String? = nil) {
        self.name = name
    }

    func update(name: String) {
        self.name = name
    }
}
