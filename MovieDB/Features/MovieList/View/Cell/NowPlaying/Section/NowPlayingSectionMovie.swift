//
//  NowPlayingSectionMovie.swift
//  MovieDB
//
//  Created by William on 20/02/22.
//

import UIKit
import Networking

class NowPlayingSectionMovie: UICollectionViewCell {
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
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    private lazy var rating: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "orange_rate")!
        label.font = .systemFont(ofSize: 14)
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
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
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
    private lazy var movieImage: UIImageView = {
        let imageVW = UIImageView()
        imageVW.backgroundColor = .lightGray
        return imageVW
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(data: MovieResponse) {
        title.text = data.title
        rating.text = "\(data.voteAverage ?? 0)"
        date.text = data.releaseDate ?? ""

        var movie = data
        let url = URL(string: movie.getMovieImg())
        movieImage.kf.setImage(with: url)
    }

    private func setUI() {
        containerGradient.addSubview(descStack)
        self.contentView.addSubviews(movieImage, containerGradient)
    }

    private func setConstraint() {
        movieImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerGradient.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        descStack.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
}
