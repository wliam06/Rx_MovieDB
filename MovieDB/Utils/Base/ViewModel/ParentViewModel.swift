//
//  ParentViewModel.swift
//  MovieDB
//
//  Created by William on 30/04/22.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx
import SwiftUI

enum ViewState: Equatable {
    case start
    case loading
    case finish
    case error
}

//enum ViewEvent: Equatable {
//    case processing
//    case success
//    case cancel
//    case fail
//    case done
//}

class ParentViewModel: HasDisposeBag {
    @RxPublished var viewState: ViewState = .start
//    @RxPublished var viewAction: ViewEvent = .processing

    // MARK: - ViewController Lifecycle
    /// didLoad: Using `viewDidLoad` ViewController lifecycle
    func didLoad() {}
    /// didLoad: Using `viewWillAppear` ViewController lifecycle
    func willAppear() {}
    /// didLoad: Using `viewDidDisappear` ViewController lifecycle
    func didDisappear() {}
}
