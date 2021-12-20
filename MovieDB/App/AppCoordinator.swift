//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {
    private(set) var window: UIWindow?

    init(window: UIWindow?) {
        super.init()

        self.window = window
    }

    override func start() {
        super.start()
    }
}
