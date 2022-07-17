//
//  Routing.swift
//  MovieDB
//
//  Created by William on 25/12/21.
//

import RxFramework

public protocol RoutingFlowCoordinator: Routable, ReactiveCompatible {}
extension RoutingFlowCoordinator {
    public var router: Router<ScreenRoute> {
        return Router(self)
    }
}
