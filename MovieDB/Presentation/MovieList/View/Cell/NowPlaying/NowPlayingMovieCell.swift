//
//  NowPlayingMovieCell.swift
//  MovieDB
//
//  Created by William on 06/02/22.
//

import UIKit

final class NowPlayingMovieCell: UITableViewCell {
    private lazy var movieImage: UIImageView = {
        let imageVW = UIImageView()
        imageVW.backgroundColor = .lightGray
        return imageVW
    }()
    private lazy var containerGradient: GradientView = {
        let view = GradientView()
        view.startLocation = 0.25
        view.endLocation = 0.75
        view.startColor = .clear
        view.endColor = .black.withAlphaComponent(0.5)
        return view
    }()
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Movie Title Here"
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    private lazy var rating: UILabel = {
        let label = UILabel()
        label.text = "7.3"
        label.textColor = UIColor(named: "orange_rate")!
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .right
        return label
    }()
    private lazy var firstSection: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.addMultipleArrangeSubviews(title, rating)
        return stack
    }()
    private lazy var date: UILabel = {
        let label = UILabel()
        label.text = "Date here"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    private lazy var descStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.backgroundColor = .clear
        stack.addMultipleArrangeSubviews(firstSection, date)
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(data: [MovieResponse]) {
        print("now playing title: ", data.first?.title)
    }

    private func loadUI() {
        self.backgroundColor = .red
        containerGradient.addSubview(descStack)
        self.addSubviews(movieImage, containerGradient)

        setupConstraint()
    }

    private func setupConstraint() {
        movieImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerGradient.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        descStack.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
}
