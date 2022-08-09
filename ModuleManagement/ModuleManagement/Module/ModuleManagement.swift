//
//  ModuleManagement.swift
//  ModuleManagement
//
//  Created by William on 08/08/22.
//

import Foundation

public final class ModuleManagement {
    public static let shared = ModuleManagement()

    private var modules = [Any]()

    /// Register module
    /// - Parameter modules: module classes
    public func register(modules: [Any]) {
        self.modules = modules
    }

    /// To access a module by using ModuleManageable Protocols
    /// - Returns: module classes
    public func module<T>(withType type: T.Type) -> T? {
        for module in modules {
            if module is T {
                return module as? T
            }
        }
        return nil
    }
}
