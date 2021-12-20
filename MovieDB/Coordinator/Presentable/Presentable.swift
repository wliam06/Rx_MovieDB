//
//  Presentable.swift
//  MovieDB
//
//  Created by William on 19/12/21.
//

import UIKit

/// Represents as a controller
protocol Presentable: AnyObject {
    /// Return self controller
    var viewController: UIViewController { get }

    /// Set root of the window
    func setRoot(for window: UIWindow)

    /// To present a controller
    func presented(from controller: Presentable?)
}

extension Presentable {
    func setRoot(for window: UIWindow) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        presented(from: window)
    }

    func presented(from controller: Presentable?) {}
}

extension UIViewController: Presentable {
    var viewController: UIViewController {
        return self
    }
}

extension UIWindow: Presentable {
    var viewController: UIViewController {
        return window?.rootViewController ?? UIViewController()
    }
}
