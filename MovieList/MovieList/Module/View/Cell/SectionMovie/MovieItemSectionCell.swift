//
//  MovieItemSectionCell.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit
import ImageCache

class MovieItemSectionCell: UICollectionViewCell {
    private lazy var movieImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()

        self.contentView.isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(imageUrl: URL) {
        movieImage.kf.setImage(with: imageUrl)
    }

    private func setupUI() {
        self.contentView.addSubview(movieImage)
        movieImage.kf.indicatorType = .activity
        movieImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
