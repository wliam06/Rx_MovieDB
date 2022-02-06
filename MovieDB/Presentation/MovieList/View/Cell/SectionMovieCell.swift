//
//  SectionMovieCell.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit

class SectionMovieCell: UICollectionViewCell {
    private lazy var movieImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(poster: String?) {
        if let poster = poster {
            let url = URL(string: NetworkConfig.imageBaseURL + poster)
            movieImage.kf.setImage(with: url)
        } else {
            movieImage.backgroundColor = .darkGray
        }
    }

    private func setupUI() {
        self.addSubview(movieImage)
        movieImage.backgroundColor = .darkGray
        movieImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
