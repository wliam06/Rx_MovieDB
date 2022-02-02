//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit
import RxSwift

enum AppRoute: Route {
    case MovieList
}

final class AppCoordinator: BaseCoordinator, RoutingFlowCoordinator {
    private(set) var window: UIWindow?
    private(set) var navigationRoute: NavigationRoute!
 
    let dependency = DependencyInjection()

    init(window: UIWindow?) {
        self.window = window

        super.init()

        dependency.registerAllDependencies()
        let navigation = dependency.resolve(type: NavigationRoute.self)
        self.navigationRoute = navigation
        self.navigationRoute.setRootVC(window: window)
    }

    override func start() {
        navigateTo(route: .MovieList)
    }

    func navigateTo(route: AppRoute, animated: Bool) {
        switch route {
        case .MovieList:
            let movieListCoordinator = MovieListCoordinator(
                navigationRoute: navigationRoute,
                dependency: dependency
            )
            movieListCoordinator.start()
        }
    }
}
