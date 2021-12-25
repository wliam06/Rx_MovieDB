//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit
import RxSwift

enum AppRoute: Route {
    case nowPlaying
}

final class AppCoordinator: BaseCoordinator, RoutingFlowCoordinator {
    private(set) var window: UIWindow?
    private(set) var navigationRoute: NavigationRoute!
 
    let dependency = DependencyInjection()

    init(window: UIWindow?) {
        self.window = window

        super.init()

        dependency.registerAllDependencies()
        self.navigationRoute = dependency.resolve(type: NavigationRoute.self)
        self.window?.rootViewController = self.navigationRoute.navigationController
        self.window?.makeKeyAndVisible()
    }

    override func start() {
        navigateTo(route: .nowPlaying)
    }

    func navigateTo(route: AppRoute, animated: Bool) {
        switch route {
        case .nowPlaying:

            let nowPlayingCoordinator = NowPlayingCoordinator(
                navigationRoute: navigationRoute,
                dependency: dependency
            )
            nowPlayingCoordinator.start()

            navigationRoute.navigationDidFinish.subscribe(onNext: { [weak self] in
                self?.$onFinish.onNext($0)
            }).disposed(by: rx.disposeBag)
        }
    }

}
