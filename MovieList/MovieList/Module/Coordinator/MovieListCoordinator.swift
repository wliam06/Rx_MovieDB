//
//  MovieListCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit
import RxFramework
import Core
import MovieDetail

enum MovieListRoute: Route {
    case list
    case detail(id: Int)
}

final class MovieListCoordinator: BaseCoordinator, RoutingFlowCoordinator {
    @Injected(\.navRoute) var navigationRoute: NavigationRoute

    override func start() {
        navigateTo(route: .list)
    }

    func navigateTo(route: MovieListRoute, animated: Bool) {
        switch route {
        case .list:
            let viewModel = MovieListViewModel(router: router)
            let view = MovieListViewController()
            view.bind(to: viewModel)
            navigationRoute.pushTo(view) { [weak self] in
                guard let self = self else { return }
                self.$onFinish.onNext(true)
            }
        case .detail(let id):
            MovieDetailModule.configure(movieId: id)
        }
    }
}
