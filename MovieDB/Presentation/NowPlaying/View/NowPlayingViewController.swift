//
//  NowPlayingViewController.swift
//  MovieDB
//
//  Created by William on 26/08/21.
//

import UIKit

class NowPlayingViewController: ViewController, BindableType {
    var viewModel: NowPlayingViewModel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = .red
    }

    override func loadUI() {
        super.loadUI()

    }
}
