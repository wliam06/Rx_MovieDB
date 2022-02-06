//
//  UpcomingView.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit
import SnapKit
import Kingfisher
import NSObject_Rx

class UpcomingView: UIView, HasDisposeBag {
    lazy var indicator: UIActivityIndicatorView = {
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

    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Upcoming"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        collection.backgroundColor = .clear
        collection.registerCells(SectionMovieCell.self)
        return collection
    }()

    private(set) var viewModel: MovieListViewModel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = .clear
        self.addSubview(indicator)
        self.addSubview(title)
        self.addSubview(collectionView)

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

extension UpcomingView: UICollectionViewDelegateFlowLayout {
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
