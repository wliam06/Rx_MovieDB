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
        
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

class BaseCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    @RxSignal var didFinish: Observable<Bool>

    // Overriding method
    func start() {}
}
