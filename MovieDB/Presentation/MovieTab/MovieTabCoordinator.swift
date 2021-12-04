//
//  MovieTabCoordinator.swift
//  MovieDB
//
//  Created by William on 26/08/21.
//

import UIKit

enum MovieTab: FlowScreen {
    case home

    enum Action: FlowAction {}
}

class MovieTabCoordinator: TabBarCoordinator<MovieTab> {
    private let container: Container

    init(container: Container) {
        self.container = container

        super.init()

        self.controller.tabBar.isTranslucent = false
        self.controller.tabBar.barTintColor = .black
        self.controller.tabBar.tintColor = .white
        
        prepare(to: [.home])
    }

    override func prepare(to screen: [MovieTab]) {
        var home: HomeCoordinator!

        screen.forEach {
            switch $0 {
            case .home:
                home = HomeCoordinator(container: container)
                home.controller.tabBarItem = UITabBarItem(
                    title: "Home",
                    image: UIImage(named: "ic_home"),
                    tag: 0
                )
            }

            setViewController([home])
        }
    }
}
