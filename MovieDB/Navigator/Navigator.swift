//
//  Navigator.swift
//  MovieDB
//
//  Created by William on 22/12/21.
//

import Foundation
import RxSwift

protocol RoutingFlowCoordinator: Routable, ReactiveCompatible {}
extension RoutingFlowCoordinator {
    var router: Router<ScreenRoute> {
        return Router(self)
    }
}
