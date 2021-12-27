//
//  BaseCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxSwift
import UIKit

class BaseCoordinator: Coordinator {
//    func start() -> Observable<Void> {
//        return .never()
//    }
//    
//    func coordinate(_ coordinator: Coordinator) -> Observable<Void> {
//        return .never()
//    }
    var childCoordinators: [Coordinator] = []
    @RxSignal var onFinish: Observable<Bool>
    func start() {}
}
