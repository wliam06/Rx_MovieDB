//
//  NowPlayingView.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit
import SnapKit
import Kingfisher
import NSObject_Rx

class NowPlayingView: UIView, HasDisposeBag {
    private lazy var indicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activity.style = .large
        } else {
            // Fallback on earlier versions
            activity.style = .whiteLarge
        }
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Now Playing"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        collection.backgroundColor = .clear
        collection.registerCells(NowPlayingCell.self)
        return collection
    }()

    private(set) var viewModel: NowPlayingViewModel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupConstraint()
    }

    convenience init(viewModel: NowPlayingViewModel) {
        self.init(frame: .zero)

        self.viewModel = viewModel
        self.binding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = .clear
        self.addSubview(indicator)
        self.addSubview(title)
        self.addSubview(collectionView)
    }

    private func binding() {
        rx.bind(
            viewModel.activityLoading ~> indicator.rx.isAnimating
        )
        viewModel.moviesResult.bind(
            to: collectionView.rx.items(cellType: NowPlayingCell.self)
        ) { index, data, cell in
            cell.configure(poster: data.posterPath)
        }.disposed(by: disposeBag)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }

    private func setupConstraint() {
        indicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension NowPlayingView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width
        let size = (width - 30) / 2
        return CGSize(width: size, height: size / 0.6)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
