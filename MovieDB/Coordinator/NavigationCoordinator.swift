//
//  NavigationCoordinator.swift
//  MovieDB
//
//  Created by William on 20/08/21.
//

import UIKit

public protocol NavigationType {
    /** Pops all the view controllers on the stack except the root view controller and updates the display. */
    @discardableResult
    func popToRootViewController(animated: Bool) -> [UIViewController]?

    /** Pops view controllers until the specified view controller is at the top of the navigation stack. */
    @discardableResult
    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]?
    
    /** Pops the top view controller from the navigation stack and updates the display. */
    @discardableResult
    func popViewController(animated: Bool) -> UIViewController?

    /** Pushes a view controller onto the receiver’s stack and updates the display. */
    func push(_ viewController: UIViewController, animated: Bool, onPoppedCompletion: (() -> Void)?)

    /** Replaces all the view controllers currently managed by the navigation controller a new root view controller. */
    func setRootViewController(from window: UIWindow, viewController: UIViewController, animated: Bool)
}

public extension NavigationType {
    func push(_ viewController: UIViewController, animated: Bool) {
        push(viewController, animated: animated, onPoppedCompletion: nil)
    }
}

typealias NavigationTransition = Transition<UINavigationController>
extension Transition where RootViewController: UINavigationController {}

struct Transition<RootViewController: UIViewController>: PresentationCoordinator {}

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

//class BaseNavigationCoordinator: BaseCoordinator, NavigationType {
//    private let navigationController: UINavigationController
//    private var completions: [UIViewController: () -> Void]
//
//    public init(navigationController: UINavigationController = UINavigationController()) {
//        self.navigationController = navigationController
//        self.completions = [:]
//
//        super.init()
//
//        self.navigationController.delegate = self
//    }
//
//    func popToRootViewController(animated: Bool) -> [UIViewController]? {
//        if let poppedControllers = navigationController.popToRootViewController(animated: animated) {
//            poppedControllers.forEach { runCompletion(for: $0) }
//            return poppedControllers
//        }
//        return nil
//    }
//
//    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
//        if let poppedControllers = navigationController.popToViewController(viewController, animated: animated) {
//            poppedControllers.forEach { runCompletion(for: $0) }
//            return poppedControllers
//        }
//        return nil
//    }
//
//    func popViewController(animated: Bool) -> UIViewController? {
//        if let poppedController = navigationController.popViewController(animated: animated) {
//            runCompletion(for: poppedController)
//            return poppedController
//        }
//        return nil
//    }
//
//    func push(_ viewController: UIViewController, animated: Bool, onPoppedCompletion: (() -> Void)? = nil) {
//        if let completion = onPoppedCompletion {
//            completions[viewController] = completion
//        }
//        navigationController.pushViewController(viewController, animated: animated)
//    }
//
//    func setRootViewController(from window: UIWindow, viewController: UIViewController, animated: Bool) {
//        completions.forEach { $0.value() }      // call completions so all view controllers are deallocated
//        completions = [:]
//        navigationController.setViewControllers([viewController], animated: animated)
//        window.rootViewController = navigationController
//    }
//
//    private func runCompletion(for controller: UIViewController) {
//        guard let completion = completions[controller] else { return }
//        completion()
//        childCoordinators.removeAll()
//        completions.removeValue(forKey: controller)
//    }
//}
//
//extension BaseNavigationCoordinator: UINavigationControllerDelegate {
//    // Runs completion handler when a user swipes-to-go-back or taps the back button in the navigation bar.
//    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        guard let poppingViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),    // ensure the view controller is popping
//            !navigationController.viewControllers.contains(poppingViewController) else {
//                return
//        }
//
//        runCompletion(for: poppingViewController)
//    }
//}
