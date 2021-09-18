//
//  NavigationCoordinator.swift
//  MovieDB
//
//  Created by William on 20/08/21.
//

import UIKit

class NavigationCoordinator<RouteType: FlowScreen>: BaseCoordinator<RouteType, NavigationTransition>, NavigationType {
    private var completions: [UIViewController: () -> Void] = [:]

    var navigationController: UINavigationController
    
    override init(rootViewController: RootViewController = .init()) {
        self.navigationController = rootViewController
        super.init(rootViewController: rootViewController)
    }

    func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if let poppedControllers = navigationController.popToRootViewController(animated: animated) {
            poppedControllers.forEach { runCompletion(for: $0) }
            return poppedControllers
        }
        return nil
    }

    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if let poppedControllers = navigationController.popToViewController(viewController, animated: animated) {
            poppedControllers.forEach { runCompletion(for: $0) }
            return poppedControllers
        }
        return nil
    }

    func popViewController(animated: Bool) -> UIViewController? {
        if let poppedController = navigationController.popViewController(animated: animated) {
            runCompletion(for: poppedController)
            return poppedController
        }
        return nil
    }

    func push(_ viewController: UIViewController, animated: Bool, onPoppedCompletion: (() -> Void)? = nil) {
        if let completion = onPoppedCompletion {
            completions[viewController] = completion
        }
        navigationController.pushViewController(viewController, animated: animated)
    }

    func setRootViewController(from window: UIWindow, viewController: UIViewController, animated: Bool) {
        completions.forEach { $0.value() }      // call completions so all view controllers are deallocated
        completions = [:]
        navigationController.setViewControllers([viewController], animated: animated)
        window.rootViewController = navigationController
    }

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        childCoordinators.removeAll()
        completions.removeValue(forKey: controller)
    }
}
