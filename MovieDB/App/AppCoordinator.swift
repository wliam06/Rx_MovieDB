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
    private(set) var navigationController: UINavigationController!
    private(set) var window: UIWindow?

    let depedency = DependencyInjection()

    init(window: UIWindow?) {
        super.init()

        self.window = window

        navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        depedency.registerAllDependencies()
    }

    override func start() {
        navigateTo(route: .nowPlaying)
    }

    func navigateTo(route: AppRoute, animated: Bool) {
        switch route {
        case .nowPlaying:
            let nowPlayingCoordinator = NowPlayingCoordinator(
                navigationController: navigationController,
                dependency: depedency
            )
            nowPlayingCoordinator.navigateTo(route: .nowPlaying, animated: true)            
        }
    }

//    func navigateTo(route: Route, animated: Bool) {
//        guard let route = route as? AppRoute else { return }
//
//        switch route {
//        case .nowPlaying:
//            let nowPlayingCoordinator = NowPlayingCoordinator(
//                navigationController: navigationController,
//                dependency: depedency
//            )
//
//            window?.rootViewController = navigationController
//            window?.makeKeyAndVisible()
//        }
//    }
    
//    override func start() {
//        super.start()
//
//        navigationController = UINavigationController()
//        let nowPlayingCoordinator = NowPlayingCoordinator(
//            navigationController: navigationController,
//            dependency: depedency
//        )
//        nowPlayingCoordinator.start()
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
//    }
}
