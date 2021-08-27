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

    init(window: UIWindow?) {
        self.window = window
    }

    override func start() {
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
