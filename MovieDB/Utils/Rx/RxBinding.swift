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
    func bind<T>(_ binding: Binding<T>...) {
        for bind in binding {
            bind.0
                .bind(to: bind.1)
                .disposed(by: disposeBag)
        }
    }
}

// MARK: operator

/*
 example usage

 rx.bind(
    loginButton.rx.tap ~> vm.loginTapped,
    emailButton.rx.tap ~> vm.emailTapped
 )
 rx.bind(
    table.rx.modelSelected ~> { [unowned self] in self.router.navigate(to: .someScreen($0) }
 )
 */

infix operator ~>

func ~><T, O: ObservableConvertibleType, B: ObserverType>(
    _ lhs: O,
    _ rhs: B
) -> Binding<T> where O.Element == T, B.Element == T {
    return (lhs.asObservable(), rhs.asObserver())
}

func ~><T, O: ObservableConvertibleType>(_ lhs: O, _ rhs: @escaping (T) -> Void) -> Binding<T> where O.Element == T {
    return (lhs.asObservable(), AnyObserver {
        switch $0 {
        case .next(let element):
            rhs(element)
        default:
            break
        }
    })
}
