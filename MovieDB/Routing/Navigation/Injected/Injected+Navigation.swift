//
//  DI+Navigation.swift
//  MovieDB
//
//  Created by William on 02/02/22.
//

private struct NavigationFlowProviderKey: InjectionKey {
    static var currentValue: NavigationRoute = NavigationFlowRoute()
}

extension InjectedValue {
    var navRoute: NavigationRoute {
        get { Self[NavigationFlowProviderKey.self] }
        set { Self[NavigationFlowProviderKey.self] = newValue }
    }
}
