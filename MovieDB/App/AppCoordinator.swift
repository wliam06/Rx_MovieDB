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
    private let depedency: Dependency

    init(window: UIWindow?,
         depedency: Dependency = AppDependency()) {
        self.window = window
        self.depedency = depedency
    }

    override func start() {
        // TODO: Create navigation custom
        self.navigationController.setNavigationBarHidden(true, animated: true)
        navigate(to: .tab)
    }

    override func navigate(to screen: AppScreen, animated: Bool) {
        switch screen {
        case .tab:
            let coordinator = MovieTabCoordinator()
            self.setRootViewController(from: window!,
                                       viewController: coordinator.controller,
                                       animated: true)
        }
    }
}
