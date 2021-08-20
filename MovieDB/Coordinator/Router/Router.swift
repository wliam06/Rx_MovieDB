//
//  Router.swift
//  MovieDB
//
//  Created by William on 20/08/21.
//

import RxSwift

protocol FlowScreen {}

protocol Route: AnyObject {
    associatedtype Screen: FlowScreen
    func navigate(to screen: Screen, animated: Bool)
}

final class Router<Screen: FlowScreen>: Route {
    private let navigateTo: (Screen, Bool) -> Void

    init<T: Route>(_ router: T) where T.Screen == Screen {
        self.navigateTo = router.navigate
    }

    func navigate(to screen: Screen, animated: Bool) {
        navigateTo(screen, animated)
    }
}

extension Route {
    func navigate(to screen: Screen) {
        navigate(to: screen, animated: true)
    }
}

extension Reactive where Base: Route {
    func navigate<Screen: FlowScreen>(to screen: Screen) -> AnyObserver<Void>
        where Base.Screen == Screen {
        AnyObserver { [unowned base] in
            switch $0 {
            case .next:
                base.navigate(to: screen, animated: true)
            default:
                break
            }
        }
    }
}

extension Router: ReactiveCompatible {}

protocol RoutingFlowCoordinator: Route, ReactiveCompatible {}

extension RoutingFlowCoordinator {
    var router: Router<Screen> {
        return Router(self)
    }
}
