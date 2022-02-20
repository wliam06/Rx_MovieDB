//
//  SectionMovieCell.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit
import SnapKit
import Kingfisher
import NSObject_Rx

class SectionMovieCell: UITableViewCell, HasDisposeBag {
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
        label.font = .boldSystemFont(ofSize: 18)
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
        collection.registerCells(MovieItemSectionCell.self)
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    private(set) var movies = [MovieResponse]() {
        didSet {
            collectionView.reloadData()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(sectionTitle: String, data: [MovieResponse]) {
        title.text = sectionTitle
        movies = data
    }

    private func setupUI() {
        self.contentView.addSubviews(indicator, title, collectionView)
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
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(300)
        }
    }
}

extension SectionMovieCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieItemSectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let movieUrlPath = movies[indexPath.row].getMovieImg()
        cell.bind(imageUrl: URL(string: movieUrlPath)!)
        return cell
    }

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
