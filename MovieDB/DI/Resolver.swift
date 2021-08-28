//
//  Resolver.swift
//  MovieDB
//
//  Created by William on 28/08/21.
//

import Foundation

/// Instance service
protocol Resolver {
    /// Resolves to an instance of `ServiceType` and throws if no instance/factory has already been registered.
    func resolve<ServiceType>(_ type: ServiceType.Type) throws -> ServiceType
    func resolve<ServiceType>() throws -> ServiceType
}
