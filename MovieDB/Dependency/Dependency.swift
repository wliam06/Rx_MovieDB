//
//  Dependency.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation

/** How to use register
 let container = DIContainer()
 container.register(type: ServiceOneProtocol.self) { _ in
    return ClassServiceOne()
 }
 
 container.register(type: ServiceTwoProtocol.self) { container in
    return ClassServiceTwo(serviceOne: container.resolve(type: ServiceOne.self)!)
 }

 **/
typealias FactoryClosure = (DependencyInjection) -> AnyObject

// Configurable used to add a method that enables
// the object to be configured but doesn't define
// what the configuration type is.
protocol Configurable {
    // Generic Configuration
    associatedtype Configuration
    func configure(configuration: Configuration)
}

protocol Dependency {
    // Generic service
    func register<Service>(type: Service.Type, factoryClosure: @escaping FactoryClosure)
    // Create an object that conform protocol
    func resolve<Service>(type: Service.Type) -> Service
    // Conform Configurable Protocol
    func resolve<Service: Configurable>(type: Service.Type, configuration: Service.Configuration) -> Service
}

class DependencyInjection: Dependency {
    // Hold all factories
    var services = Dictionary<String, FactoryClosure>()

    func register<Service>(
        type: Service.Type,
        factoryClosure: @escaping FactoryClosure
    ) {
        services["\(type)"] = factoryClosure
    }

    func resolve<Service>(
        type: Service.Type
    ) -> Service {
        return services["\(type)"]?(self) as! Service
    }

    // Use to custom values
    func resolve<Service>(
        type: Service.Type,
        configuration: Service.Configuration
    ) -> Service where Service: Configurable {
        let service = resolve(type: type)
        service.configure(configuration: configuration)
        return service
    }
}
