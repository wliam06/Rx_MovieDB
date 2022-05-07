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
        collection.frame.size.height = 300
        collection.backgroundColor = .clear
        collection.registerCells(MovieItemSectionCell.self)
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    private lazy var stackContent: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fill
        return stack
    }()

    private(set) var movies = [MovieResponse]()

    var movieDidTap: ((MovieResponse) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(
        sectionTitle: String,
        data: [MovieResponse],
        action: ((MovieResponse) -> Void)? = nil
    ) {
        title.text = sectionTitle
        movies = data
        movieDidTap = action
        collectionView.reloadData()
    }

    private func setupUI() {
        self.contentView.backgroundColor = .clear
        stackContent.addMultipleArrangeSubviews(title, collectionView)
        self.contentView.addSubviews(indicator, stackContent)
    }

    private func setupConstraint() {
        indicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        stackContent.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        collectionView.snp.makeConstraints {
            $0.height.equalTo(300).priority(.low)
        }
    }
}

extension SectionMovieCell: UICollectionViewDelegate,
                            UICollectionViewDataSource,
                            UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard movies.count > 0 else {
            return UICollectionViewCell()
        }

        let cell: MovieItemSectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let movieUrlPath = movies[indexPath.row].getMovieImg()
        cell.bind(imageUrl: URL(string: movieUrlPath)!)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard movies.count > 0 else { return }
        self.movieDidTap?(movies[indexPath.row])
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width
        let size = (width - 30) / 2
        return CGSize(width: size, height: 300)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
