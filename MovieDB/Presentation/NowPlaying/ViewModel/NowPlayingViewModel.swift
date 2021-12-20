//
//  NowPlayingViewModel.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Foundation

protocol NowPlayingViewModelInput {}
protocol NowPlayingViewModelOutput {}
protocol NowPlayingViewModel: NowPlayingViewModelInput & NowPlayingViewModelOutput {}

final class ImpNowPlayingViewModel: NowPlayingViewModel {}
