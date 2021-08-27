//
//  UpcomingCoordinator.swift
//  MovieDB
//
//  Created by William on 27/08/21.
//

import Foundation

enum UpcomingScreen: FlowScreen {
    case Upcoming

    enum Action: FlowAction {}
}

class UpcomingCoordinator: NavigationCoordinator<UpcomingScreen> {
    init() {
        super.init()
        navigate(to: .Upcoming)
    }

    override func navigate(to screen: UpcomingScreen, animated: Bool) {
        switch screen {
        case .Upcoming:
            let viewController = UpcomingViewController()
            let viewModel = ImpUpcomingViewModel()
            viewController.bind(to: viewModel)
//            self.push(controller, animated: animated)
        }
    }
}
