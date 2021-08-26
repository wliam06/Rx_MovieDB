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
    override func start() {
        navigate(to: .nowPlaying)
    }

    override func navigate(to screen: NowPlayingScreen, animated: Bool) {
        switch screen {
        case .nowPlaying:
            print("now playing here")
            self.push(NowPlayingViewController(), animated: animated)
        default:
            break
        }
    }
}
