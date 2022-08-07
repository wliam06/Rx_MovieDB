//
//  MockRouter.swift
//  MovieListTests
//
//  Created by William on 24/07/22.
//

import XCTest
import Core
import RxFramework
@testable import MovieList

class MockRouter<ScreenRoute: Route>: Routable {
    @RxPublished var route: ScreenRoute?

    var isNavigate = false

    func navigateTo(route: ScreenRoute, animated: Bool) {
        self.route = route
        self.isNavigate = true
    }
    
    public var router: Router<ScreenRoute> {
        Router(self)
    }
}
