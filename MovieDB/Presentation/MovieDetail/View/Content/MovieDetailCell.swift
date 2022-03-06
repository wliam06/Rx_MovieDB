//
//  MovieDetailCell.swift
//  MovieDB
//
//  Created by William on 28/02/22.
//

import UIKit

class MovieDetailCell: UITableViewCell {
    private lazy var titleName: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    private lazy var movieName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    private lazy var movieSection: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillProportionally
        stack.addMultipleArrangeSubviews(titleName, movieName)
        return stack
    }()

    private lazy var titleRelease: UILabel = {
        let label = UILabel()
        label.text = "Release Date:"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    private lazy var releaseDate: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    private lazy var releaseSection: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.addMultipleArrangeSubviews(titleRelease, releaseDate)
        return stack
    }()
    private lazy var titleGenre: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    private lazy var genreCollection: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.sectionInset = .zero
        viewLayout.minimumLineSpacing = 4
        viewLayout.minimumInteritemSpacing = 4

        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        collection.backgroundColor = .clear
        collection.registerCells(CategoryItemCell.self)
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = false
        return collection
    }()
    private lazy var genreSection: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.addMultipleArrangeSubviews(titleGenre, genreCollection)
        return stack
    }()
    private lazy var desc: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addMultipleArrangeSubviews(
            movieSection,
            releaseSection,
            genreSection,
            desc
        )
        stack.spacing = 8
        return stack
    }()

    var defaultHeight: CGFloat = 40

    private var genres = [MovieGenreResult]()
    var item: MovieDetailResponse?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(movie: MovieDetailResponse?) {
        guard let movie = movie else { return }
        movieName.text = movie.title ?? "-"
        releaseDate.text = movie.releaseDate ?? "-"
        desc.text = movie.overview ?? "-"

        // Set movie genre
        if let genres = movie.genres {
            titleGenre.text = genres.count > 2 ? "Genres:" : "Genre:"
            self.genres = genres

            let newHeight = genres.count > 3 ? defaultHeight + defaultHeight : defaultHeight
            genreSection.snp.updateConstraints {
                $0.height.equalTo(newHeight)
            }
            genreCollection.reloadData()
        } else {
            genreSection.isHidden = true
        }
    }

    private func setUI() {
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(contentStack)

        contentStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
        genreCollection.snp.makeConstraints {
            $0.height.equalTo(defaultHeight)
        }
    }
}

extension MovieDetailCell: UICollectionViewDelegate,
                           UICollectionViewDataSource,
                           UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard genres.count > 0 else {
            return UICollectionViewCell()
        }

        let cell: CategoryItemCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.name = genres[indexPath.row].name ?? "-"
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CategoryItemCell.size(text: genres[indexPath.row].name ?? "")
    }
}
