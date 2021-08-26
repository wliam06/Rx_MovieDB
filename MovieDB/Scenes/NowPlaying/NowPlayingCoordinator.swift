//
//  NowPlayingCoordinator.swift
//  MovieDB
//
//  Created by William on 26/08/21.
//

import Foundation

enum NowPlayingScreen: FlowScreen {
    case nowPlaying

    enum Action: FlowAction {}
}

class NowPlayingCoordinator: NavigationCoordinator<NowPlayingScreen> {
    init() {
        super.init()
        navigate(to: .nowPlaying)
    }

    override func navigate(to screen: NowPlayingScreen, animated: Bool) {
        switch screen {
        case .nowPlaying:
            self.push(NowPlayingViewController(), animated: animated)
        default:
            break
        }
    }
}
