//
//  CategoryItemCell.swift
//  MovieDB
//
//  Created by William on 28/02/22.
//

import UIKit

class CategoryItemCell: UICollectionViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    static func size(text: String?) -> CGSize {
        guard let text = text else {
            return .zero
        }

        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 12)
        label.text = text
        label.sizeToFit()
        return CGSize(width: label.frame.width + 40, height: 32)
    }

    var name: String? {
        didSet {
            guard let name = self.name else { return }

            containerView.layer.borderWidth = 1.5
            containerView.layer.masksToBounds = false
            containerView.layer.cornerRadius = 16
            containerView.layer.borderColor = UIColor.darkGray.cgColor

            self.title.text = name
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        containerView.addSubview(title)
        self.contentView.addSubview(containerView)

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        title.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(4)
            $0.bottom.equalTo(containerView.snp.bottom).offset(-4)
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
    }
}
