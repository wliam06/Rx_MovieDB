//
//  Coordinator.swift
//  MovieDB
//
//  Created by William on 20/08/21.
//

import UIKit
import RxSwift

protocol Coordinator: Router {
    var childCoordinators: [Presentable] { get set }
    var didFinish: Observable<Bool> { get }
    func start()
}

extension Coordinator where Self: ReactiveCompatible {
    func start<T: Coordinator>(_ coordinator: T) {
        coordinator.didFinish.subscribe(onNext: { [weak self] _ in
            self?.childCoordinators.removeAll { $0 is T }
        }).disposed(by: rx.disposeBag)

        addChild(coordinator)
        coordinator.start()
    }
}

extension Coordinator where Self: Presentable {}
extension Coordinator {
    func addChild(_ coordinator: Presentable) {
        childCoordinators.append(coordinator)
    }

    func removeChild(_ coordinator: Presentable) {
        childCoordinators.removeAll { $0.rootViewController === coordinator.rootViewController }
    }
}

class BaseCoordinator<RouteType: FlowScreen, Presentation: PresentationCoordinator>: Coordinator {
    typealias Screen = RouteType

    var childCoordinators: [Presentable] = []
    @RxSignal var didFinish: Observable<Bool>

    func start() {}

    var rootViewController: UIViewController {
        return controller
    }

    private(set) var controller: RootViewController

    init(rootViewController: RootViewController) {
        self.controller = rootViewController
    }

    func navigate(to screen: RouteType, animated: Bool) {}
    func trigger(to screen: RouteType.Action) {}
    func prepare(to screen: [RouteType]) {}
}

extension BaseCoordinator {
    typealias RootViewController = Presentation.RootViewController
}
