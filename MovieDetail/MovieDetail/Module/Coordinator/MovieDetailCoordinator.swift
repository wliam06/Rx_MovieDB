//
//  MovieDetailCoordinator.swift
//  MovieDetail
//
//  Created by William on 17/07/22.
//

import UIKit
import RxFramework
import Core

public enum MovieDetailRoute: Route {
    case main(id: Int)
}

public final class MovieDetailCoordinator: BaseCoordinator, RoutingFlowCoordinator {
    @Injected(\.navRoute) var navigationRoute: NavigationRoute

    private(set) var movieId: Int

    public init(id: Int) {
        self.movieId = id
    }

    public override func start() {
        navigateTo(route: .main(id: movieId))
    }

    public func navigateTo(route: MovieDetailRoute, animated: Bool) {
        switch route {
        case .main(let id):
            let viewModel = MovieDetailViewModel(id)
            let view = MovieDetailViewController()
            view.bind(to: viewModel)
            navigationRoute.pushTo(view) { [weak self] in
                guard let self = self else { return }
                self.$onFinish.onNext(true)
            }
        }
    }
}
