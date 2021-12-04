//
//  Rx+ActivityIndicator.swift
//  MovieDB
//
//  Created by William on 04/12/21.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIActivityIndicatorView {
    /// Bind activity animation state
    var isAnimating: Binder<Bool> {
        return Binder(base) { activityIndicator, isAnimating in
            isAnimating ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }
}
