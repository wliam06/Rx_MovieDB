//
//  NowPlayingMovieCell.swift
//  MovieDB
//
//  Created by William on 06/02/22.
//

import UIKit
import RxSwift
import NSObject_Rx

final class NowPlayingMovieCell: UITableViewCell {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: UIScreen.main.bounds.size.width, height: 300)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        return collection
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.backgroundColor = .clear
        stack.spacing = 12
        return stack
    }()

    private(set) var movies = [MovieResponse]() {
        didSet {
            self.collectionView.reloadData()
        }
    }

    var movieDidTap: ((MovieResponse) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(data: [MovieResponse], action: ((MovieResponse) -> Void)? = nil) {
        self.movies = data
        movieDidTap = action
    }

    private func setUI() {
        stack.addMultipleArrangeSubviews(collectionView)
        self.contentView.addSubview(stack)
        collectionView.registerCells(NowPlayingSectionMovie.self)
    }

    private func setConstraint() {
        stack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        collectionView.snp.makeConstraints {
            $0.height.equalTo(300)
        }
    }
}

extension NowPlayingMovieCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: NowPlayingSectionMovie = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.bind(data: movies[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard movies.count > 0 else { return }
        self.movieDidTap?(movies[indexPath.row])
    }
}
