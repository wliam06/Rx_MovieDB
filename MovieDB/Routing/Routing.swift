//
//  Routing.swift
//  MovieDB
//
//  Created by William on 25/12/21.
//

import Foundation

protocol RoutingFlowCoordinator: Routable, ReactiveCompatible {}
extension RoutingFlowCoordinator {
    var router: Router<ScreenRoute> {
        return Router(self)
    }
}
