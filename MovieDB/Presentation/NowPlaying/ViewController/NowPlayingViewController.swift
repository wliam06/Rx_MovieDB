//
//  NowPlayingViewController.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit

class NowPlayingViewController: UIViewController, Bindable {
    var viewModel: NowPlayingViewModel!

    override func viewDidLoad() {
        self.view.backgroundColor = .systemBlue
        super.viewDidLoad()
    }

    // Binding ViewModel
    func bindViewModel() {
    }
}
