//
//  MovieDetailViewModelTests.swift
//  MovieDBTests
//
//  Created by William on 26/06/22.
//

import XCTest
//import Core
import RxFramework

@testable import Core
@testable import MovieDetail

public class MockMovieDetailModel {
    func result() -> MovieDetailModel {
        return MovieDetailModel(
            title: "Movie Title",
            releaseDate: "release",
            overview: "overview",
            movieImg: "movies.png",
            genres: nil
        )
    }
}

public enum MockErrorResponse: Error {
    case someError
}

class MovieDetailViewModelTests: XCTestCase {
    var sut: MovieDetailViewModel!
    var usecase: MockMovieDetailUseCase!
    var mock: MockMovieDetailModel!

    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()

        sut = MovieDetailViewModel(1)
        usecase = MockMovieDetailUseCase()
        mock = MockMovieDetailModel()
        sut.usecase = usecase
    }

    override func tearDown() {
        sut = nil
        usecase = nil
        mock = nil
        super.tearDown()
    }

    func testSuccessDidLoad() {
        usecase.stubbedFetchMovieDetailResult = .just(mock.result())
        sut.stateMachine = StateMachine(
            initialState: .isLoading,
            routing: MovieDetailViewModel.State.routes,
            effects: { [weak self] in
                self?.sut.effectHandler(effect: $0)
            })
        let expected = MovieDetailViewModel.State.successLoadMovie([MockMovieDetailModel().result()])
        sut.stateMachine.transition(.viewDidLoad)
        sut.stateMachine.onTransitionResult(onSuccess: { (testA, newState, testC) in
            XCTAssertEqual(newState, expected)
        })
        XCTAssertTrue(sut.stateMachine.currentState.movieDetail.count > 0)
        XCTAssertTrue(usecase.invokedFetchMovieDetail)
    }

    func testErrorGetMovieDetail() {
        usecase.stubbedFetchMovieDetailResult = .error(MockErrorResponse.someError)
        sut.stateMachine = StateMachine(
            initialState: .isLoading,
            routing: MovieDetailViewModel.State.routes,
            effects: { [weak self] in
                self?.sut.effectHandler(effect: $0)
            })
        let expected = MovieDetailViewModel.State.error
        sut.stateMachine.transition(.didReceiveError)
        sut.didLoad()
        sut.stateMachine.onTransitionResult(onSuccess: { (_, newState, _) in
            XCTAssertEqual(newState, expected)
        })
    }

    func testClearMovieDetail() {
        sut.stateMachine = StateMachine(
            initialState: .successLoadMovie([MockMovieDetailModel().result()]),
            routing: MovieDetailViewModel.State.routes,
            effects: { [weak self] in
                self?.sut.effectHandler(effect: $0)
            })
        let expected = MovieDetailViewModel.State.isLoading
        sut.stateMachine.transition(.viewDidDisappear)
        sut.stateMachine.onTransitionResult(onSuccess: { (_, newState, _) in
            XCTAssertEqual(newState, expected)
        })
    }
}

