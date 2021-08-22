//
//  Router.swift
//  MovieDB
//
//  Created by William on 20/08/21.
//

import RxSwift

protocol FlowScreen {}

protocol Router: AnyObject, Presentable {
    associatedtype Screen: FlowScreen

    func navigate(to screen: Screen, animated: Bool)
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

    init<T: Router>(_ router: T) where T.Screen == Screen {
        self.navigateTo = router.navigate
        self.rootViewController = router.root
    }
    
    func navigate(to screen: Screen, animated: Bool) {
        navigateTo(screen, animated)
    }
}

extension RouterImp: ReactiveCompatible {}
