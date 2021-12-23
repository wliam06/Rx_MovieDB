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
//    func start() -> AnyObserver<Void>
    func start()
    var onFinish: Observable<Bool> { get }
}

extension Coordinator {
//    func start() -> AnyObserver<Void> {
//        fatalError("As start coordinator")
//    }
    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

extension Coordinator where Self: ReactiveCompatible {
//    func start<T: Coordinator>(child: T) -> AnyObserver<Void> {
//        self.store(coordinator: child)
//        return AnyObserver { [weak self] in
//            switch $0 {
//            case .next:
//                self?.free(coordinator: child)
//            default: break
//            }
//        }
//    }
    func start<T: Coordinator>(child: T) {
        self.store(coordinator: child)
        child.onFinish.subscribe(onNext: { [weak self] _ in
            self?.free(coordinator: child)
        }).disposed(by: rx.disposeBag)
        child.start()
//        AnyObserver { [weak self] in
//            switch $0 {
//            case .next:
//                self?.free(coordinator: child)
//            default: break
//            }
//        }
    }
}
