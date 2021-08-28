//
//  ResolverFactory.swift
//  MovieDB
//
//  Created by William on 28/08/21.
//

import Foundation

/// Conform service type
/// type-safe implementation
protocol ResolverFactory {
    associatedtype ServiceType

    /// tries resolving/generating the instance of generic type using the passed `Resolver`
    func resolve(_ resolver: Resolver) -> ServiceType
}

extension ResolverFactory {
    /// Checks if the service factory supports creation of the specific `ServiceType`
    func supports<ServiceType>(_ type: ServiceType.Type) -> Bool {
        return type == ServiceType.self
    }
}

/// BaseResolverFactory used to produce instances as classes by passing Resolver.
struct BaseResolverFactory<ServiceType>: ResolverFactory {
    private let factory: (Resolver) -> ServiceType

    /// Initialize
    /// - Parameters:
    ///   - type: The type of the object that this factory supports/creates
    ///   - factory: Takes a resolver and should return an instance of the type
    init(_ type: ServiceType.Type, factory: @escaping (Resolver) -> ServiceType) {
        self.factory = factory
    }

    /// tries resolving/generating the instance of generic type using the passed `Resolver`
    func resolve(_ resolver: Resolver) -> ServiceType {
        return factory(resolver)
    }
}
