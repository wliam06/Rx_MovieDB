//
//  RxBinding.swift
//  MovieDB
//
//  Created by William on 20/08/21.
//

import RxSwift
import RxCocoa
import NSObject_Rx

typealias Binding<T> = (Observable<T>, AnyObserver<T>)

extension Reactive where Base: AnyObject {
    /// binds for the lifetime of default dispose bag
    /// - Parameter bindings: list of bindings
    func bind<T>(binding: Binding<T>...) {
        for bind in binding {
            bind.0
                .bind(to: bind.1)
                .disposed(by: disposeBag)
        }
    }
}
