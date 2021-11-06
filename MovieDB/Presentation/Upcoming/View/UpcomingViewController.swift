//
//  UpcomingViewController.swift
//  MovieDB
//
//  Created by William on 27/08/21.
//

import UIKit

class UpcomingViewController: ViewController, BindableType {
    var viewModel: UpcomingViewModel!

    override func loadUI() {
        super.loadUI()

        self.view.backgroundColor = .green
    }
}
