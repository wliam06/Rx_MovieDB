//
//  HomeViewController.swift
//  MovieDB
//
//  Created by William on 26/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: ViewController, BindableType {
    private lazy var indicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activity.style = .large
        } else {
            // Fallback on earlier versions
            activity.style = .whiteLarge
        }
        activity.color = .darkGray
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    var viewModel: HomeViewModel!

    override func loadUI() {
        super.loadUI()

        self.view.addSubview(indicator)
    }

    override func setConstraint() {
        super.setConstraint()

        NSLayoutConstraint.activate(
            [
                indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                indicator.heightAnchor.constraint(equalToConstant: 30),
                indicator.widthAnchor.constraint(equalToConstant: 30)
            ]
        )
    }

    override func bindViewModel() {
        super.bindViewModel()
        
        rx.bind(
            viewModel.$isLoading ~> indicator.rx.isAnimating
        )
    }
}
