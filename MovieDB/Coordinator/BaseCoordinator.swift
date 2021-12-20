//
//  BaseCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxSwift

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    @RxSignal var didFinish: Observable<Bool>

    func start() {}
}
