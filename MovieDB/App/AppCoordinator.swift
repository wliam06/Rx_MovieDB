//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit
import RxFramework
import Core
import MovieList
import MovieDetail
import ModuleManagement

enum AppRoute: Route {
    case movieList
}

final class AppCoordinator: BaseCoordinator, RoutingFlowCoordinator {
    private(set) var window: UIWindow?
    @Injected(\.navRoute) var navigationRoute: NavigationRoute

    init(window: UIWindow?) {
        self.window = window

        super.init()

        navigationRoute.setRootVC(window: window)
    }

    override func start() {
        ModuleManagement.shared.register(
            modules: [
                MovieListModule.shared,
                MovieDetailModule.shared
            ]
        )
        navigateTo(route: .movieList)
    }

    func navigateTo(route: AppRoute, animated: Bool) {
        switch route {
        case .movieList:
            ModuleManagement.shared.module(withType: MovieListManageModule.self)?.start()
        }
    }
}
