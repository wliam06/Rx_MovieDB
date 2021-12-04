//
//  PrimitiveSequence+Thread.swift
//  MovieDB
//
//  Created by William on 21/11/21.
//

import RxSwift

extension PrimitiveSequence {
    /// Run observable in background thread and back to mainthread
    public func runInThread() -> PrimitiveSequence<Trait, Element> {
        return self.subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
    }
}
