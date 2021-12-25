//
//  BaseCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxSwift
import UIKit

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    @RxSignal var onFinish: Observable<Bool>
    func start() {}
}
