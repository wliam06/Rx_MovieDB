//
//  Presentable.swift
//  MovieDB
//
//  Created by William on 22/12/21.
//

import UIKit
import RxSwift

/// An abstraction of what can be presented to the screen.
protocol Presentable {}

extension UIViewController: Presentable {
    var viewController: UIViewController! {
        self
    }
}
