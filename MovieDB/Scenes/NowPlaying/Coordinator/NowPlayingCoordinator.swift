//
//  NowPlayingCoordinator.swift
//  MovieDB
//
//  Created by William on 26/08/21.
//

import UIKit

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
            let viewController = NowPlayingViewController()
            let viewModel = ImpNowPlayingViewModel()
            viewController.bind(to: viewModel)
//            self.push(controller, animated: animated)
        }
    }
}
