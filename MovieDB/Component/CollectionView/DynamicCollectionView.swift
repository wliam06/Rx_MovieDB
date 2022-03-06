//
//  DynamicCollectionView.swift
//  MovieDB
//
//  Created by William on 06/03/22.
//

import UIKit

class DynamicCollectionView: UICollectionView {
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
