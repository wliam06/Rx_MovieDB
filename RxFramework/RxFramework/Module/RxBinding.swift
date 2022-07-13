//
//  RxBinding.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import RxSwift
import RxCocoa
import NSObject_Rx

typealias Binding<T> = (Observable<T>, AnyObserver<T>)

extension Reactive where Base: AnyObject {
    /// binds on main thread for the lifetime of default dispose bag
    /// - Parameter bindings: list of bindings
    func bind<T>(_ bindings: Binding<T>...) {
        for b in bindings {
            b.0.observe(on: MainScheduler.instance)
                .bind(to: b.1)
                .disposed(by: disposeBag)
        }
    }

    /// convenience bind for single binding using { } instead of ( )
    /// - Parameter b: single binding
    func bind<T>(_ b: () -> Binding<T>) {
        b().0.observe(on: MainScheduler.instance)
            .bind(to: b().1)
            .disposed(by: disposeBag)
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

func ~><T, O: ObservableConvertibleType, B: ObserverType>(_ lhs: O, _ rhs: B) -> Binding<T> where O.Element == T, B.Element == T {
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
