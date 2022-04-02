//
//  MockMovieListViewModel.swift
//  MovieDBTests
//
//  Created by William on 02/04/22.
//

import XCTest

@testable import MovieDB

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

    var invokedIsLoadingSetter = false
    var invokedIsLoadingSetterCount = 0
    var invokedIsLoading: Bool?
    var invokedIsLoadingList = [Bool]()
    var invokedIsLoadingGetter = false
    var invokedIsLoadingGetterCount = 0
    var stubbedIsLoading: Bool! = false

    override var isLoading: Bool {
        set {
            invokedIsLoadingSetter = true
            invokedIsLoadingSetterCount += 1
            invokedIsLoading = newValue
            invokedIsLoadingList.append(newValue)
        }
        get {
            invokedIsLoadingGetter = true
            invokedIsLoadingGetterCount += 1
            return stubbedIsLoading
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

    var invokedIsNowPlayingLoadingSetter = false
    var invokedIsNowPlayingLoadingSetterCount = 0
    var invokedIsNowPlayingLoading: Bool?
    var invokedIsNowPlayingLoadingList = [Bool]()
    var invokedIsNowPlayingLoadingGetter = false
    var invokedIsNowPlayingLoadingGetterCount = 0
    var stubbedIsNowPlayingLoading: Bool! = false

    override var isNowPlayingLoading: Bool {
        set {
            invokedIsNowPlayingLoadingSetter = true
            invokedIsNowPlayingLoadingSetterCount += 1
            invokedIsNowPlayingLoading = newValue
            invokedIsNowPlayingLoadingList.append(newValue)
        }
        get {
            invokedIsNowPlayingLoadingGetter = true
            invokedIsNowPlayingLoadingGetterCount += 1
            return stubbedIsNowPlayingLoading
        }
    }

    var invokedIsPopularLoadingSetter = false
    var invokedIsPopularLoadingSetterCount = 0
    var invokedIsPopularLoading: Bool?
    var invokedIsPopularLoadingList = [Bool]()
    var invokedIsPopularLoadingGetter = false
    var invokedIsPopularLoadingGetterCount = 0
    var stubbedIsPopularLoading: Bool! = false

    override var isPopularLoading: Bool {
        set {
            invokedIsPopularLoadingSetter = true
            invokedIsPopularLoadingSetterCount += 1
            invokedIsPopularLoading = newValue
            invokedIsPopularLoadingList.append(newValue)
        }
        get {
            invokedIsPopularLoadingGetter = true
            invokedIsPopularLoadingGetterCount += 1
            return stubbedIsPopularLoading
        }
    }

    var invokedIsUpcomingLoadingSetter = false
    var invokedIsUpcomingLoadingSetterCount = 0
    var invokedIsUpcomingLoading: Bool?
    var invokedIsUpcomingLoadingList = [Bool]()
    var invokedIsUpcomingLoadingGetter = false
    var invokedIsUpcomingLoadingGetterCount = 0
    var stubbedIsUpcomingLoading: Bool! = false

    override var isUpcomingLoading: Bool {
        set {
            invokedIsUpcomingLoadingSetter = true
            invokedIsUpcomingLoadingSetterCount += 1
            invokedIsUpcomingLoading = newValue
            invokedIsUpcomingLoadingList.append(newValue)
        }
        get {
            invokedIsUpcomingLoadingGetter = true
            invokedIsUpcomingLoadingGetterCount += 1
            return stubbedIsUpcomingLoading
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
}
