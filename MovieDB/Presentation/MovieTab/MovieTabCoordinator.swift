//
//  MovieTabCoordinator.swift
//  MovieDB
//
//  Created by William on 26/08/21.
//

import UIKit

enum MovieTab: FlowScreen {
    case nowPlaying
    case upcoming
    
    enum Action: FlowAction {}
}

class MovieTabCoordinator: TabBarCoordinator<MovieTab> {
    init() {
        super.init()

        prepare(to: [.nowPlaying, .upcoming])
    }

    override func prepare(to screen: [MovieTab]) {
        var nowPlaying: NowPlayingCoordinator!
        var upcoming: UpcomingCoordinator!

        screen.forEach {
            switch $0 {
            case .nowPlaying:
                nowPlaying = NowPlayingCoordinator()
                nowPlaying.controller.tabBarItem = UITabBarItem(title: "Now Playing", image: nil, tag: 0)
            case .upcoming:
                upcoming = UpcomingCoordinator()
                upcoming.controller.tabBarItem = UITabBarItem(title: "Upcoming", image: nil, tag: 1)
            }
        }

        setViewController([nowPlaying, upcoming])
    }
}