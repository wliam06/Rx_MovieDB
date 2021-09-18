//
//  NavigationType.swift
//  MovieDB
//
//  Created by William on 12/09/21.
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
