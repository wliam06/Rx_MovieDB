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
    @Injected(\.navRoute) var navigationRoute: NavigationRoute

    override func start() {
        navigateTo(route: .list)
    }

    func navigateTo(route: MovieListRoute, animated: Bool) {
        switch route {
        case .list:
            let viewModel = ImpMovieListViewModel(router: router)
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
