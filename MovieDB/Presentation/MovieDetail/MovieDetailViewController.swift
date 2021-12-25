//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by William on 21/12/21.
//

import UIKit

class MovieDetailViewController: UIViewController, Bindable {
    var viewModel: MovieDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }

    func bindViewModel() {}
}
