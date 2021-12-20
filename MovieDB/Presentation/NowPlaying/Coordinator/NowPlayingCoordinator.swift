//
//  NowPlayingCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation
import UIKit

final class NowPlayingCoordinator: BaseCoordinator {
    private weak var navigationController: UINavigationController?
    private var dependency: Dependency

    init(navigationController: UINavigationController, dependency: Dependency) {
        self.navigationController = navigationController
        self.dependency = dependency
    }

    override func start() {
        super.start()

        let view = NowPlayingViewController()
        let usecase =  dependency.resolve(type: MovieListUseCase.self)
        let viewModel = ImpNowPlayingViewModel(usecase: usecase)
        view.bind(to: viewModel)

        navigationController?.pushViewController(view, animated: true)
    }
}
