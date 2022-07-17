//
//  BaseCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxFramework
import UIKit

open class BaseCoordinator: Coordinator {
//    func start() -> Observable<Void> {
//        return .never()
//    }
//    
//    func coordinate(_ coordinator: Coordinator) -> Observable<Void> {
//        return .never()
//    }
    public var childCoordinators: [Coordinator] = []
    @RxSignal public var onFinish: Observable<Bool>
    open func start() {}
    public init() {}
}
