//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by William on 27/08/21.
//

import Foundation

protocol HomeViewModelInput: AnyObject {
}

protocol HomeViewModelOutput: AnyObject {
}

protocol HomeViewModel: RxDisposeable, HomeViewModelInput & HomeViewModelOutput {}
