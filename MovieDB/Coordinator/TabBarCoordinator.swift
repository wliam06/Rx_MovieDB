//
//  TabBarCoordinator.swift
//  MovieDB
//
//  Created by William on 21/08/21.
//

import UIKit


typealias TabBarTransition = Transition<UITabBarController>
extension Transition where RootViewController: UITabBarController {}

class TabBarCoordinator<RouteType: FlowScreen>: BaseCoordinator<RouteType, TabBarTransition> {
    
    override init(rootViewController: RootViewController = .init()) {
        super.init(rootViewController: rootViewController)
    }

    func setViewController(_ tabs: [Presentable]) {
        controller.setViewControllers(tabs.map { $0.rootViewController }, animated: true)
    }
}
