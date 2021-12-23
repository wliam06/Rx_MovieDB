//
//  BaseCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxSwift
import UIKit

class BaseCoordinator: Coordinator {
    @RxSignal var onFinish: Observable<Bool>
    var childCoordinators: [Coordinator] = []

//    func start() -> AnyObserver<Void> {
//        Logger.error("Start should be implemented")
//        fatalError("Start should be implemented")
//    }
    func start() {}
}
