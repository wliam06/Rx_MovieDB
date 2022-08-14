//
//  Observable+Driver.swift
//  RxFramework
//
//  Created by William on 23/07/22.
//

import RxSwift
import RxCocoa

public extension ObservableType {
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
}
