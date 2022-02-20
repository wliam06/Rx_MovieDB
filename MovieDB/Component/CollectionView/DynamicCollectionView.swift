//
//  DynamicCollectionView.swift
//  MovieDB
//
//  Created by William on 20/02/22.
//

import UIKit

class DynamicCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
