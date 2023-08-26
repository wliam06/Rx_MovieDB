//
//  MovieDetailSampleCoordinator.swift
//  MovieDetailSample
//
//  Created by William on 26/08/23.
//

import Foundation
import ModuleManagement
import UIKit
import RxFramework
import Core
import MovieDetail

final class MovieDetailSampleCoordinator: BaseCoordinator {
    private(set) var window: UIWindow?
    @Injected(\.navRoute) var navigationRoute: NavigationRoute

    init(window: UIWindow?) {
        self.window = window

        super.init()
        navigationRoute.setRootVC(window: window)
        // Register module
        ModuleManagement.shared.register(
            modules: [
                MovieDetailModule.shared
            ]
        )
    }

    override func start() {
        let movieID: Int = 709631
        ModuleManagement.shared.module(withType: MovieDetailModule.self)?.start(movieId: movieID)
    }
}
