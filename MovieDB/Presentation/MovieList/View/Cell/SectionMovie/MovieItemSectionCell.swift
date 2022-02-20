//
//  MovieItemSectionCell.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit

class MovieItemSectionCell: UICollectionViewCell {
    private lazy var movieImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(imageUrl: URL) {
        movieImage.kf.setImage(with: imageUrl)
    }

    private func setupUI() {
        self.addSubview(movieImage)
        movieImage.backgroundColor = .darkGray
        movieImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
