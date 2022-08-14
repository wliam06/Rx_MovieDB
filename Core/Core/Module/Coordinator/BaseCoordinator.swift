//
//  BaseCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxFramework
import UIKit

open class BaseCoordinator: Coordinator {
    public var childCoordinators: [Coordinator] = []
    @RxSignal public var onFinish: Observable<Bool>
    open func start() {}
    open func start(with option: DeeplinkOption?) {}
    public init() {}
}
