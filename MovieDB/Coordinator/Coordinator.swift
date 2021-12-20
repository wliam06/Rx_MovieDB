//
//  Coordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxSwift
import NSObject_Rx

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var didFinish: Observable<Bool> { get }
    func start()
}

extension Coordinator where Self: ReactiveCompatible {
    func start<T: Coordinator>(child: T) {
        child.didFinish.subscribe(onNext: { [weak self] _ in
            self?.childCoordinators.removeAll { $0 is T }
        }).disposed(by: rx.disposeBag)
        childCoordinators.append(child)
        child.start()
    }
}

