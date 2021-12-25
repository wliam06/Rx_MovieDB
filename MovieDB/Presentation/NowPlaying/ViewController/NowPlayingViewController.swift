//
//  NowPlayingViewController.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit
import NSObject_Rx

class NowPlayingViewController: UIViewController, Bindable, HasDisposeBag {
    internal lazy var contentView = NowPlayingView()

    var viewModel: NowPlayingViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .colorMode(light: .white, dark: .black)
        self.view.addSubview(contentView)

        contentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
    }

    // Binding ViewModel
    func bindViewModel() {
        rx.bind(
            viewModel.activityLoading ~> contentView.indicator.rx.isAnimating
        )
        viewModel.moviesResult.bind(
            to: contentView.collectionView.rx.items(cellType: NowPlayingCell.self)
        ) { index, data, cell in
            cell.configure(poster: data.posterPath)
        }.disposed(by: disposeBag)

        contentView.collectionView.rx.itemSelected.subscribe(onNext: { [weak self] _ in
            self?.viewModel.didSelectMovie()
        }).disposed(by: disposeBag)
    }
}
