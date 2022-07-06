//
//  ImpInjection.swift
//  MovieDB
//
//  Created by William on 06/07/22.
//

import Foundation

private struct ImpInjectionKey: InjectionKey {
    static var currentValue: InjectionProtocol = ImpInjection()
}

extension InjectedValue {
    var strongInjection: InjectionProtocol {
        get { Self[ImpInjectionKey.self] }
        set { Self[ImpInjectionKey.self] = newValue }
    }
}

private struct ImpWeakInjectionKey: InjectionWeakKey {
    static weak var currentValue: InjectionProtocol?
}
extension InjectedWeakValue {
    var weakInjection: InjectionProtocol? {
        get { Self[ImpWeakInjectionKey.self] }
        set { Self[ImpWeakInjectionKey.self] = newValue }
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

// Weak references
final class ImpWeakInjection: InjectionProtocol {
    var name: String?

    @InjectedWeak(\.weakInjection) var injected

    init(name: String? = nil) {
        self.name = name
    }

    func update(name: String) {
        self.name = name
    }
}
