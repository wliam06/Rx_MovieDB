//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by William on 20/08/21.
//

import UIKit

//enum AppScreen: FlowScreen {
//    case first
//}
//
//class AppCoordinator: BaseNavigationCoordinator, RoutingFlow {
//    private let window: UIWindow?
//
//    init(window: UIWindow?) {
//        self.window = window
//    }
//
//    override func start() {
//        navigate(to: .first, animated: true)
//    }
//
//    func navigate(to screen: AppScreen, animated: Bool) {
//        switch screen {
//        case .first:
//            let vc = ViewController()
//            self.setRootViewController(from: window!, viewController: vc, animated: true)
//        }
//    }
//}

enum AppScreen: FlowScreen {
    case first
}

class AppCoordinator: NavigationCoordinator<AppScreen> {
    private let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    override func start() {
        navigate(to: .first)
    }

    override func navigate(to screen: AppScreen, animated: Bool) {
        switch screen {
        case .first:
            let vc = ViewController()
            self.setRootViewController(from: window!, viewController: vc, animated: true)
        }
    }
}
