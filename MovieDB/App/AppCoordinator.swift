//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {
    private(set) var navigationController: UINavigationController!
    private(set) var window: UIWindow?

    let depedency = DependencyInjection()

    init(window: UIWindow?) {
        super.init()

        self.window = window
        depedency.registerAllDependencies()
    }

    override func start() {
        super.start()

        navigationController = UINavigationController()
        let nowPlayingCoordinator = NowPlayingCoordinator(
            navigationController: navigationController,
            dependency: depedency
        )
        nowPlayingCoordinator.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
//        let view = NowPlayingViewController()
//        let viewModel = ImpNowPlayingViewModel()
//        view.bind(to: viewModel)
//        navigationController = UINavigationController(rootViewController: view)
//        window?.rootViewController = navigationController
    }
}
