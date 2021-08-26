//
//  Router.swift
//  MovieDB
//
//  Created by William on 20/08/21.
//

import RxSwift

protocol FlowAction {}

protocol FlowScreen {
    associatedtype Action: FlowAction
}

protocol Router: AnyObject, Presentable {
    associatedtype Screen: FlowScreen

    func navigate(to screen: Screen, animated: Bool)
    func trigger(to screen: Screen.Action)
    func prepare(to screen: Screen)
}

extension Router {
    func navigate(to screen: Screen) {
        navigate(to: screen, animated: true)
    }
}

extension Reactive where Base: Router {
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

    func trigger<Action: FlowAction>(action: Action) -> AnyObserver<Void> where Base.Screen.Action == Action {
        AnyObserver { [unowned base] in
            switch $0 {
            case .next:
                base.trigger(to: action)
            default:
                break
            }
        }
    }

    func prepare<Screen: FlowScreen>(to screen: Screen) -> AnyObserver<Void>
        where Base.Screen == Screen {
        AnyObserver { [unowned base] in
            switch $0 {
            case .next:
                base.prepare(to: screen)
            default:
                break
            }
        }
    }
}

extension Router where Self: Presentable {
    var router: RouterImp<Screen> {
        return RouterImp(self)
    }
}

extension Router where Self: ReactiveCompatible {}

final class RouterImp<Screen: FlowScreen>: Router {
    var rootViewController: UIViewController

    private let navigateTo: (Screen, Bool) -> Void
    private let triggerTo: (Screen.Action) -> Void
    private let prepareTo: (Screen) -> Void

    init<T: Router>(_ router: T) where T.Screen == Screen {
        self.navigateTo = router.navigate
        self.triggerTo = router.trigger
        self.prepareTo = router.prepare
        self.rootViewController = router.rootViewController
    }
    
    func navigate(to screen: Screen, animated: Bool) {
        navigateTo(screen, animated)
    }

    func trigger(to screen: Screen.Action) {
        triggerTo(screen)
    }

    func prepare(to screen: Screen) {
        prepareTo(screen)
    }
}

extension RouterImp: ReactiveCompatible {}
