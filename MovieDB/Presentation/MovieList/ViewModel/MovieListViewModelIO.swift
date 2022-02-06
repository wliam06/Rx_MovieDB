//
//  MovieListViewModelIO.swift
//  MovieDB
//
//  Created by William on 22/12/21.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

protocol MovieListViewModelInput {
    var isLoading: Bool { get}
    var page: Int { get }

    func didSelectMovie()
}

protocol MovieListViewModelOutput {
    var activityLoading: BehaviorSubject<Bool>.Observer { get }
    var nowPlayingResult: BehaviorSubject<[MovieResponse]>.Observer { get }
    var nowPlayingLoaded: BehaviorSubject<Bool>.Observer { get }

    var upcomingResult: BehaviorSubject<[MovieResponse]>.Observer { get }
    var upcomingLoaded: BehaviorSubject<Bool>.Observer { get }

    var popularResult: BehaviorSubject<[MovieResponse]>.Observer { get }
    var popularLoaded: BehaviorSubject<Bool>.Observer { get }
    
    var currentPage: BehaviorSubject<Int>.Observer { get }
}

protocol MovieListViewModel: MovieListViewModelInput & MovieListViewModelOutput {}
