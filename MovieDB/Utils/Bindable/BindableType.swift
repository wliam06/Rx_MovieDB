//
//  BindableType.swift
//  MovieDB
//
//  Created by William on 27/08/21.
//

import UIKit

protocol BindableType: AnyObject {
    associatedtype ViewModelType

    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    func bind(to vm: Self.ViewModelType) {
        viewModel = vm
        loadViewIfNeeded()
        bindViewModel()
    }
}
