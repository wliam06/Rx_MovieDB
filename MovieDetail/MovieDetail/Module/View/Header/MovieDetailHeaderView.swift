//
//  MovieDetailHeaderView.swift
//  MovieDB
//
//  Created by William on 28/02/22.
//

import UIKit
import MovieKit
import NetworkSwift

class MovieDetailHeaderView: UIView {
    private lazy var image = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(_ movieImg: String) {
        if let url = URL(string: movieImg) {
            image.kf.setImage(with: url)
        }
    }

    private func setupUI() {
        image.backgroundColor = .darkGray
        self.addSubview(image)

        image.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
