//
//  NavigationFlow.swift
//  MovieDB
//
//  Created by William on 22/12/21.
//

import UIKit
import RxSwift


/// Trigger navigation from route
protocol NavigationRoute: AnyObject {
    var navigationController: UINavigationController { get }
    var navigationDidFinish: Observable<Bool> { get }

    func pushTo(_ presented: UIViewController, animated: Bool)
}

extension NavigationRoute {
    func back(animated: Bool) {
        if let presented = navigationController.presentedViewController {
            presented.dismiss(animated: animated)
        } else {
            navigationController.popViewController(animated: animated)
        }
    }

    func pushTo(_ presented: UIViewController) {
        pushTo(presented, animated: true)
    }
}

extension NavigationRoute where Self: BaseCoordinator {
    func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: animated) {
            self.$onFinish.onNext(true)
        }
    }

    func pushTo(_ presented: UIViewController) {
        pushTo(presented, animated: true)
    }
}

/// Handling navigation flow from route
final class NavigationFlowRoute: NSObject, NavigationRoute {
    var navigationController: UINavigationController
    @RxSignal var navigationDidFinish: Observable<Bool>

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }

    func pushTo(_ presented: UIViewController, animated: Bool) {
        navigationController.pushViewController(presented, animated: animated)
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

        self.$navigationDidFinish.onNext(true)
    }
}
