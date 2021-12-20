//
//  NowPlayingViewController.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit

class NowPlayingViewController: UIViewController, Bindable {
    private lazy var nowPlayingView = NowPlayingView()

    var viewModel: NowPlayingViewModel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .colorMode(light: .white, dark: .black)
        nowPlayingView = NowPlayingView(viewModel: viewModel)
        self.view.addSubview(nowPlayingView)

        nowPlayingView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
    }

    // Binding ViewModel
    func bindViewModel() {}
}
