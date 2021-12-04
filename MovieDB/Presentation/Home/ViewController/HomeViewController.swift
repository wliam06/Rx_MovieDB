//
//  HomeViewController.swift
//  MovieDB
//
//  Created by William on 26/08/21.
//

import UIKit
import SnapKit

class HomeViewController: ViewController, BindableType {
    private lazy var homeView = HomeView()

    var viewModel: HomeViewModel!

    override func loadUI() {
        super.loadUI()

        self.view.addSubview(homeView)
    }

    override func setConstraint() {
        super.setConstraint()

        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func bindViewModel() {
        super.bindViewModel()
        
        rx.bind(
            viewModel.$isLoading ~> homeView.indicator.rx.isAnimating
        )
    }
}
