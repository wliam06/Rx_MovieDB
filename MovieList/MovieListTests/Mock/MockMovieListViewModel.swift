//
//  MockMovieListViewModel.swift
//  MovieDBTests
//
//  Created by William on 02/04/22.
//

import XCTest
import Core
import MovieKit
import Networking

@testable import MovieList

class MockMovieListViewModel: ImpMovieListViewModel {

    var invokedPageSetter = false
    var invokedPageSetterCount = 0
    var invokedPage: Int?
    var invokedPageList = [Int]()
    var invokedPageGetter = false
    var invokedPageGetterCount = 0
    var stubbedPage: Int! = 0

    override var page: Int {
        set {
            invokedPageSetter = true
            invokedPageSetterCount += 1
            invokedPage = newValue
            invokedPageList.append(newValue)
        }
        get {
            invokedPageGetter = true
            invokedPageGetterCount += 1
            return stubbedPage
        }
    }

    var invokedNowPlayingSetter = false
    var invokedNowPlayingSetterCount = 0
    var invokedNowPlaying: [MovieResponse]?
    var invokedNowPlayingList = [[MovieResponse]]()
    var invokedNowPlayingGetter = false
    var invokedNowPlayingGetterCount = 0
    var stubbedNowPlaying: [MovieResponse]! = []

    override var nowPlaying: [MovieResponse] {
        set {
            invokedNowPlayingSetter = true
            invokedNowPlayingSetterCount += 1
            invokedNowPlaying = newValue
            invokedNowPlayingList.append(newValue)
        }
        get {
            invokedNowPlayingGetter = true
            invokedNowPlayingGetterCount += 1
            return stubbedNowPlaying
        }
    }

    var invokedPopularSetter = false
    var invokedPopularSetterCount = 0
    var invokedPopular: [MovieResponse]?
    var invokedPopularList = [[MovieResponse]]()
    var invokedPopularGetter = false
    var invokedPopularGetterCount = 0
    var stubbedPopular: [MovieResponse]! = []

    override var popular: [MovieResponse] {
        set {
            invokedPopularSetter = true
            invokedPopularSetterCount += 1
            invokedPopular = newValue
            invokedPopularList.append(newValue)
        }
        get {
            invokedPopularGetter = true
            invokedPopularGetterCount += 1
            return stubbedPopular
        }
    }

    var invokedUpcomingSetter = false
    var invokedUpcomingSetterCount = 0
    var invokedUpcoming: [MovieResponse]?
    var invokedUpcomingList = [[MovieResponse]]()
    var invokedUpcomingGetter = false
    var invokedUpcomingGetterCount = 0
    var stubbedUpcoming: [MovieResponse]! = []

    override var upcoming: [MovieResponse] {
        set {
            invokedUpcomingSetter = true
            invokedUpcomingSetterCount += 1
            invokedUpcoming = newValue
            invokedUpcomingList.append(newValue)
        }
        get {
            invokedUpcomingGetter = true
            invokedUpcomingGetterCount += 1
            return stubbedUpcoming
        }
    }

    var invokedUsecaseSetter = false
    var invokedUsecaseSetterCount = 0
    var invokedUsecase: MovieListUseCase?
    var invokedUsecaseList = [MovieListUseCase]()
    var invokedUsecaseGetter = false
    var invokedUsecaseGetterCount = 0
    var stubbedUsecase: MovieListUseCase!

    override var usecase: MovieListUseCase {
        set {
            invokedUsecaseSetter = true
            invokedUsecaseSetterCount += 1
            invokedUsecase = newValue
            invokedUsecaseList.append(newValue)
        }
        get {
            invokedUsecaseGetter = true
            invokedUsecaseGetterCount += 1
            return stubbedUsecase
        }
    }

    var invokedViewStateSetter = false
    var invokedViewStateSetterCount = 0
    var invokedViewState: ViewState?
    var invokedViewStateList = [ViewState]()
    var invokedViewStateGetter = false
    var invokedViewStateGetterCount = 0
    var stubbedViewState: ViewState!

    override var viewState: ViewState {
        set {
            invokedViewStateSetter = true
            invokedViewStateSetterCount += 1
            invokedViewState = newValue
            invokedViewStateList.append(newValue)
        }
        get {
            invokedViewStateGetter = true
            invokedViewStateGetterCount += 1
            return stubbedViewState
        }
    }    

    var invokedDidLoad = false
    var invokedDidLoadCount = 0

    override func didLoad() {
        invokedDidLoad = true
        invokedDidLoadCount += 1
    }

    var invokedDidSelectMovie = false
    var invokedDidSelectMovieCount = 0
    var invokedDidSelectMovieParameters: (movie: MovieResponse, Void)?
    var invokedDidSelectMovieParametersList = [(movie: MovieResponse, Void)]()

    override func didSelectMovie(movie: MovieResponse) {
        invokedDidSelectMovie = true
        invokedDidSelectMovieCount += 1
        invokedDidSelectMovieParameters = (movie, ())
        invokedDidSelectMovieParametersList.append((movie, ()))
    }

    var invokedWillAppear = false
    var invokedWillAppearCount = 0

    override func willAppear() {
        invokedWillAppear = true
        invokedWillAppearCount += 1
    }

    var invokedDidDisappear = false
    var invokedDidDisappearCount = 0

    override func didDisappear() {
        invokedDidDisappear = true
        invokedDidDisappearCount += 1
    }
}
