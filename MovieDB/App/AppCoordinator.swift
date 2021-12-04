//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by William on 20/08/21.
//

import UIKit

enum AppScreen: FlowScreen {
    case tab
    enum Action: FlowAction {}
}

class AppCoordinator: NavigationCoordinator<AppScreen> {
    private let window: UIWindow?
    private let container: Container

    init(window: UIWindow?,
         container: Container = DIContainer()) {
        self.window = window
        self.container = container
    }

    override func start() {
        // Register Dependencies
        container.registerAllDependencies()

        // TODO: Create Custom Navigation Style
        self.navigationController.setNavigationBarHidden(true, animated: true)
        navigate(to: .tab)
    }

    override func navigate(to screen: AppScreen, animated: Bool) {
        switch screen {
        case .tab:
            let coordinator = MovieTabCoordinator(container: container)
            self.setRootViewController(from: window!,
                                       viewController: coordinator.controller,
                                       animated: true)
        }
    }
}
