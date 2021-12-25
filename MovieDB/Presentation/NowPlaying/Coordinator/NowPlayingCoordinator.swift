//
//  NowPlayingCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

enum NowPlayingRoute: Route {
    case nowPlaying
    case detail
}

final class NowPlayingCoordinator: RoutingFlowCoordinator {
    private(set) var navigationRoute: NavigationRoute
    private var dependency: Dependency

    init(navigationRoute: NavigationRoute, dependency: Dependency) {
        self.navigationRoute = navigationRoute
        self.dependency = dependency
    }

    func navigateTo(route: NowPlayingRoute, animated: Bool) {
        switch route {
        case .nowPlaying:
            let usecase = dependency.resolve(type: MovieListUseCase.self)

            let viewModel = ImpNowPlayingViewModel(router: router, usecase: usecase)
            let view = NowPlayingViewController()
            view.bind(to: viewModel)
            navigationRoute.pushTo(view, animated: true)
        case .detail:
            navigationRoute.pushTo(MovieDetailViewController(), animated: true)
        }
    }
}
