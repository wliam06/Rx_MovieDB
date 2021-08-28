//
//  UpcomingCoordinator.swift
//  MovieDB
//
//  Created by William on 27/08/21.
//

import Foundation

enum UpcomingScreen: FlowScreen {
    enum Action: FlowAction {}
}

class UpcomingCoordinator: NavigationCoordinator<UpcomingScreen> {
    init() {
        super.init()
        start()
    }

    override func start() {
        let viewController = UpcomingViewController()
        let viewModel = ImpUpcomingViewModel()
        viewController.bind(to: viewModel)
        self.push(viewController, animated: false)
    }
}
