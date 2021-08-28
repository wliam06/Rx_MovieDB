//
//  NowPlayingCoordinator.swift
//  MovieDB
//
//  Created by William on 26/08/21.
//

import UIKit

enum NowPlayingScreen: FlowScreen {
    enum Action: FlowAction {}
}

class NowPlayingCoordinator: NavigationCoordinator<NowPlayingScreen> {
    init() {
        super.init()

        start()
    }

    override func start() {
        let viewController = NowPlayingViewController()
        let viewModel = ImpNowPlayingViewModel()
        viewController.bind(to: viewModel)
        self.push(viewController, animated: false)
    }
}
