//
//  Router.swift
//  MovieDB
//
//  Created by William on 19/12/21.
//

import Foundation
import RxSwift

protocol Router: Presentable {
    /// RouteScreen defines which routes can be triggered in Router Implementation
    associatedtype RouteScreen: Route

    /// Navigation Route
    func navigate(_ route: RouteScreen, animated: Bool)
    /// Navigate by action
    func trigger(_ route: RouteScreen)
    /// Back action
    func back(animated: Bool)
}

extension Router {
    func navigate(_ route: RouteScreen) {
        navigate(route, animated: true)
    }

    func back() {
        back(animated: true)
    }
}

extension Reactive where Base: Router {
    func navigate<Route>(to route: Route) -> AnyObserver<Void> where Base.RouteScreen == Route {
        AnyObserver { [unowned base] in
            switch $0 {
            case .next:
                base.navigate(route)
            default:
                break
            }
        }
    }

    func trigger<Route>(to route: Route) -> AnyObserver<Void> where Base.RouteScreen == Route {
        AnyObserver { [unowned base] in
            switch $0 {
            case .next:
                base.trigger(route)
            default:
                break
            }
        }
    }

    func back() -> AnyObserver<Void> {
        AnyObserver { [unowned base] in
            switch $0 {
            case .next:
                base.back()
            default:
                break
            }
        }
    }
}
