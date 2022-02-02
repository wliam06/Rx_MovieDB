//
//  NavigationRoute.swift
//  MovieDB
//
//  Created by William on 27/12/21.
//

import UIKit
import RxSwift

/// Closure to free coordinate after used.
public typealias NavigationBack = (() -> ())

/// Trigger navigation from route
protocol NavigationRoute: AnyObject {
    var navigationController: UINavigationController { get }
    func pushTo(_ presented: UIViewController, animated: Bool, onBack: NavigationBack?)
    func setRootVC(window: UIWindow?)
}

extension NavigationRoute {
    func back(animated: Bool) {
        if let presented = navigationController.presentedViewController {
            presented.dismiss(animated: animated)
        } else {
            navigationController.popViewController(animated: animated)
        }
    }

    func pushTo(_ presented: UIViewController, onBack: NavigationBack?) {
        pushTo(presented, animated: true, onBack: onBack)
    }
}

extension Reactive where Base: NavigationRoute {
    func pushTo(_ presented: UIViewController, onBack: NavigationBack?) -> AnyObserver<Void> {
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
    func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: animated) {
            self.$onFinish.onNext(true)
        }
    }
}
