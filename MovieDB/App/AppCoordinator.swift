//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by William on 19/12/21.
//

import Foundation
import RxSwift
import UIKit

final class AppCoordinator: BaseCoordinator {
    private(set) var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    override func start() {}
}
