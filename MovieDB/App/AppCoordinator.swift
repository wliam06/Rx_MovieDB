//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by William on 20/08/21.
//

import UIKit

enum AppScreen: FlowScreen {
    case tab
    case test

    enum Action: FlowAction {}
}

class AppCoordinator: NavigationCoordinator<AppScreen> {
    private let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
//        let navController = UINavigationController()
//        super.init(rootViewController: navController)
//
//        navigationController = navController
//        window?.rootViewController = navigationController
    }

    override func start() {
        navigate(to: .tab)
    }

    override func navigate(to screen: AppScreen, animated: Bool) {
        switch screen {
        case .tab:
            let coordinator = MovieTabCoordinator()
            coordinator.start()
            self.setRootViewController(from: window!, viewController: coordinator.controller, animated: true)
        case .test:
            let vc = ViewController()
            self.setRootViewController(from: window!, viewController: vc, animated: true)
        }
    }
}
