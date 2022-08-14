//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit
import RxFramework
import Core
import MovieList
import MovieDetail
import ModuleManagement

enum AppRoute: Route {
    case movieList
    case movieDetail(Int?)
}

final class AppCoordinator: BaseCoordinator, RoutingFlowCoordinator {
    private(set) var window: UIWindow?
    @Injected(\.navRoute) var navigationRoute: NavigationRoute

    init(window: UIWindow?) {
        self.window = window

        super.init()

        navigationRoute.setRootVC(window: window)
        self.registerDependencies()
    }

    override func start(with option: DeeplinkOption?) {
        if let option = option {
            switch option {
            case .movies:
                self.navigateTo(route: .movieList, animated: true)
            case .movie(let id):
                self.navigateTo(route: .movieDetail(id), animated: true)
            }
        } else {
            self.navigateTo(route: .movieList)
        }
    }

    private func registerDependencies() {
        ModuleManagement.shared.register(
            modules: [
                MovieListModule.shared,
                MovieDetailModule.shared
            ]
        )
    }

    func navigateTo(route: AppRoute, animated: Bool) {
        switch route {
        case .movieList:
            ModuleManagement.shared.module(withType: MovieListManageModule.self)?.start()
        case .movieDetail(let id):
            ModuleManagement.shared.module(withType: MovieDetailModule.self)?.start(movieId: id)
        }
    }
}
