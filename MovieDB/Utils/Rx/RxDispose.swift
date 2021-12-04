//
//  RxDispose.swift
//  MovieDB
//
//  Created by William on 21/11/21.
//

import RxSwift

protocol RxDisposeable {
    var disposeBag: DisposeBag { get }
}

extension RxDisposeable {
    var disposeBag: DisposeBag {
        return DisposeBag()
    }
}
