//
//  MovieTabCoordinator.swift
//  MovieDB
//
//  Created by William on 26/08/21.
//

import UIKit

enum MovieTab: FlowScreen {
    case nowPlaying

    enum Action: FlowAction {}
}

class MovieTabCoordinator: TabBarCoordinator<MovieTab> {
    override func start() {
        let tab = NowPlayingCoordinator()
//        tab.rootViewController.tabBarItem = UITabBarItem(title: "Now Playing", image: nil, tag: 0)
        tab.start()
        tab.controller.tabBarItem = UITabBarItem(title: "Now Playing", image: nil, tag: 0)
        setViewController([tab])
    }
}
