//
//  NavigationRoute.swift
//  MovieDB
//
//  Created by William on 27/12/21.
//

import UIKit
import RxFramework

/// Closure to free coordinate after used.
public typealias NavigationBack = (() -> ())

/// Trigger navigation from route
public protocol NavigationRoute: AnyObject {
    var navigationController: UINavigationController { get }
    func pushTo(_ presented: UIViewController, animated: Bool, onBack: NavigationBack?)
    func setRootVC(window: UIWindow?)
    func setViewControllers(_ controllers: [UIViewController])
}

extension NavigationRoute {
    public func back(animated: Bool) {
        if let presented = navigationController.presentedViewController {
            presented.dismiss(animated: animated)
        } else {
            navigationController.popViewController(animated: animated)
        }
    }

    public func pushTo(_ presented: UIViewController, onBack: NavigationBack?) {
        pushTo(presented, animated: true, onBack: onBack)
    }
}

extension Reactive where Base: NavigationRoute {
    public func pushTo(_ presented: UIViewController, onBack: NavigationBack?) -> AnyObserver<Void> {
        AnyObserver { [unowned base] in
            switch $0 {
            case .next:
                base.pushTo(presented, onBack: onBack)
            default:
                break
            }
        }
    }
}

extension NavigationRoute where Self: BaseCoordinator {
    public func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: animated) {
            self.$onFinish.onNext(true)
        }
    }
}
