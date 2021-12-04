//
//  HomeCoordinator.swift
//  MovieDB
//
//  Created by William on 26/08/21.
//

import UIKit

enum HomeScreen: FlowScreen {
    enum Action: FlowAction {}
}

class HomeCoordinator: NavigationCoordinator<HomeScreen> {
    private let container: Container

    init(container: Container) {
        self.container = container
        super.init()

        start()
    }

    override func start() {
        let request = container.resolve(type: NetworkRequest.self)
        let repository = container.resolve(type: MovieRepository.self)
        let usecase = container.resolve(type: HomeUsecase.self)

        let viewController = HomeViewController()
        let viewModel = ImpHomeViewModel(usecase: usecase)
        viewController.bind(to: viewModel)

        self.push(viewController, animated: false)
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
}
