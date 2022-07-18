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
        navigateTo(route: .movieList)
    }

    func navigateTo(route: AppRoute, animated: Bool) {
        switch route {
        case .movieList:
            let movie = MovieListModule.configure()
        }
    }
}
