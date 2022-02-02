//
//  NavigationFlow.swift
//  MovieDB
//
//  Created by William on 22/12/21.
//

import UIKit
import RxSwift


/// Handling navigation flow from route
class NavigationFlowRoute: NSObject, NavigationRoute {
    var navigationController: UINavigationController

    private(set) var window: UIWindow?
    private var closures: [String: NavigationBack] = [:]

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        super.init()
        navigationController.delegate = self
    }

    func pushTo(_ presented: UIViewController, animated: Bool, onBack closure: NavigationBack?) {
        if let closure = closure {
            closures.updateValue(closure, forKey: presented.description)
        }

        navigationController.pushViewController(presented, animated: animated)
    }

    private func executeClosure(_ presented: UIViewController) {
        guard let closure = closures.removeValue(forKey: presented.description) else { return }
        closure()
    }

    func setRootVC(window: UIWindow?) {
        self.window = window
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func setViewControllers(_ controllers: [UIViewController]) {
        navigationController.setViewControllers(controllers, animated: false)
    }
}

extension NavigationFlowRoute: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        guard let prevController = navigationController
                .transitionCoordinator?
                .viewController(forKey: .from),
              !navigationController
                .viewControllers
                .contains(prevController) else { return }

        executeClosure(prevController)
    }
}
