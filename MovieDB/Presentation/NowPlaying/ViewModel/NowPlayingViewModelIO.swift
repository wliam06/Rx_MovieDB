//
//  NowPlayingViewModelIO.swift
//  MovieDB
//
//  Created by William on 22/12/21.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

protocol NowPlayingViewModelInput {
    var movies: [MovieResponse] { get }
    var isLoading: Bool { get}
    var page: Int { get }
}

protocol NowPlayingViewModelOutput {
    var activityLoading: BehaviorSubject<Bool>.Observer { get }
    var moviesResult: BehaviorSubject<[MovieResponse]>.Observer { get }
    var currentPage: BehaviorSubject<Int>.Observer { get }
}

protocol NowPlayingViewModel: NowPlayingViewModelInput & NowPlayingViewModelOutput {}
