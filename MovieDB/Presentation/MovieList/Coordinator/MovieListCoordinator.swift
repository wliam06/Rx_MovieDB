//
//  MovieListCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

enum MovieListRoute: Route {
    case list
    case detail
}

final class MovieListCoordinator: BaseCoordinator, RoutingFlowCoordinator {
    private var navigationRoute: NavigationRoute
    private(set) var dependency: Dependency

    init(navigationRoute: NavigationRoute, dependency: Dependency) {
        self.dependency = dependency
        self.navigationRoute = navigationRoute
    }

    override func start() {
        navigateTo(route: .list)
    }

    func navigateTo(route: MovieListRoute, animated: Bool) {
        switch route {
        case .list:
            let usecase = dependency.resolve(type: MovieListUseCase.self)
            let viewModel = ImpMovieListViewModel(router: router, usecase: usecase)
            let view = MovieListViewController()
            view.bind(to: viewModel)
            navigationRoute.pushTo(view) { [weak self] in
                guard let self = self else { return }
                self.$onFinish.onNext(true)
            }
        case .detail:
            let viewModel = ImpMovieDetailViewModel()
            let view = MovieDetailViewController()
            view.bind(to: viewModel)
            navigationRoute.pushTo(view) { [weak self] in
                guard let self = self else { return }
                self.$onFinish.onNext(true)
            }
        }
    }
}
