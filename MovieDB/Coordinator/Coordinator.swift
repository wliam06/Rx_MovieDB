//
//  Coordinator.swift
//  MovieDB
//
//  Created by William on 20/08/21.
//

import RxSwift

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
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

extension Coordinator {
    func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChild(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

class BaseCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    @RxSignal var didFinish: Observable<Bool>

    // Overriding method
    func start() {}
}
