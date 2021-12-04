//
//  PrimitiveSequence+Delayed.swift
//  MovieDB
//
//  Created by William on 21/11/21.
//

import RxSwift

extension PrimitiveSequence {
    /// shortcut for delayed requests
    public func delayed(_ ms: Int = 250) -> PrimitiveSequence<Trait, Element> {
        self.delay(.milliseconds(ms), scheduler: MainScheduler.instance)
    }
}
