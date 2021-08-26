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
    init() {
        super.init()
        prepare(to: .nowPlaying)
    }

    override func prepare(to screen: MovieTab) {
        let nowPlaying: NowPlayingCoordinator
        switch screen {
        case .nowPlaying:
            nowPlaying = NowPlayingCoordinator()
            nowPlaying.controller.tabBarItem = UITabBarItem(title: "Now Playing", image: nil, tag: 0)
        default:
            return
        }

        setViewController([nowPlaying])
    }
}
