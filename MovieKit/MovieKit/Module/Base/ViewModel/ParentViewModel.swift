//
//  ParentViewModel.swift
//  MovieDB
//
//  Created by William on 30/04/22.
//

import RxFramework

public enum ViewState: Equatable {
    case start
    case loading
    case finish
    case error
}

open class ParentViewModel: HasDisposeBag {
    @RxPublished public var viewState: ViewState = .start

    public init() {}

    // MARK: - ViewController Lifecycle
    /// didLoad: Using `viewDidLoad` ViewController lifecycle
    open func didLoad() {}
    /// didLoad: Using `viewWillAppear` ViewController lifecycle
    open func willAppear() {}
    /// didLoad: Using `viewDidDisappear` ViewController lifecycle
    open func didDisappear() {}
}
