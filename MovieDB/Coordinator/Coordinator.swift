//
//  Coordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxSwift
import NSObject_Rx

/// To coordinate which route should triggered
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()

    /// Trigger to release from coordinator
    var onFinish: Observable<Bool> { get }
}

extension Coordinator {
    /// Add Chile Coodinator
    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    /// Release Child Coordinator
    func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

extension Coordinator where Self: ReactiveCompatible {
    func start<T: Coordinator>(child: T) {
        self.store(coordinator: child)
        child.onFinish.subscribe(onNext: { [weak self] _ in
            self?.free(coordinator: child)
        }).disposed(by: rx.disposeBag)
    }
}
