//
//  AnyResolver.swift
//  MovieDB
//
//  Created by William on 28/08/21.
//

import Foundation

final class AnyResolver {
    private let _resolve: (Resolver) throws -> Any
    private let _supports: (Any.Type) -> Bool

    init<T: ResolverFactory>(_ serviceFactory: T) {

        self._resolve = { resolver -> Any in
            serviceFactory.resolve(resolver)
        }

        self._supports = { $0 == T.ServiceType.self }
    }

    func resolve<ServiceType>(_ resolver: Resolver) throws -> ServiceType {
        return try _resolve(resolver) as! ServiceType
    }

    func supports<ServiceType>(_ serviceType: ServiceType.Type) -> Bool {
        return _supports(serviceType)
    }
}
