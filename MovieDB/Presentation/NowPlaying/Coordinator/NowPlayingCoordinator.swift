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

final class NowPlayingCoordinator: BaseCoordinator, RoutingFlowCoordinator {
    private var navigationRoute: NavigationRoute
    private(set) var dependency: Dependency

    init(navigationRoute: NavigationRoute, dependency: Dependency) {
        self.dependency = dependency
        self.navigationRoute = navigationRoute
    }

    override func start() {
        navigateTo(route: .nowPlaying)
    }

    func navigateTo(route: NowPlayingRoute, animated: Bool) {
        switch route {
        case .nowPlaying:
            let usecase = dependency.resolve(type: MovieListUseCase.self)
            let viewModel = ImpNowPlayingViewModel(router: router, usecase: usecase)
            let view = NowPlayingViewController()
            view.bind(to: viewModel)
            navigationRoute.pushTo(view) { [weak self] in
                guard let self = self else { return }
                self.$onFinish.onNext(true)
            }
        case .detail:
            print("navigate to detail")
            navigationRoute.pushTo(MovieDetailViewController()) { [weak self] in
                guard let self = self else { return }
                self.$onFinish.onNext(true)
            }
        }
    }
}
