//
//  AppDependency.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation
import UIKit

extension Dependency {
    func registerAllDependencies() {
        registerNavigationFlowRoute()
        registerNetwork()
        registerNowPlaying()
    }

    func registerNavigationFlowRoute() {
        register(type: UINavigationController.self) { _ in
            return UINavigationController()
        }

        register(type: NavigationRoute.self) { (container) -> AnyObject in
            return NavigationFlowRoute(
                navigationController: container.resolve(type: UINavigationController.self)
            )
        }
    }
}
