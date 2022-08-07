//
//  MovieListViewModelTests.swift
//  MovieListTests
//
//  Created by William on 24/07/22.
//

import XCTest
import Networking
import Core
@testable import MovieList

class MovieListViewModelTests: XCTestCase {
    let mockRoute = MockRouter<MovieListRoute>()
    let mockMovie = MovieResultResponse.mock().results
    var sut: MovieListViewModel!

    override func setUp() {
        super.setUp()
        sut = MovieListViewModel(router: mockRoute.router)
    }

    func testStateSuccessOnDidLoad() {
        sut.stateMachine = StateMachine(
            initialState: .isLoading,
            routing: MovieListViewModel.State.routes,
            effects: { [weak self] in
                self?.sut.effectHandler(effect: $0)
            })
        let expected = MovieListViewModel.State.isLoading
        let expectation = expectation(description: "State isLoading")

        sut.stateMachine.transition(.viewDidLoad)
        sut.stateMachine.onTransitionResult(onSuccess: { (_, newState, _) in
            XCTAssertEqual(newState, expected)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.1)
    }

    func testStateSuccessLoadMovies() {
        sut.stateMachine = StateMachine(
            initialState: .isLoading,
            routing: MovieListViewModel.State.routes,
            effects: { [weak self] in
                self?.sut.effectHandler(effect: $0)
            })
        let expected = MovieListViewModel.State.successLoadMovies(mockMovie, mockMovie, mockMovie)
        let expectation = expectation(description: "State is successLoadMovies(_:)")

        sut.stateMachine.transition(.didSuccessLoadMovies(mockMovie, mockMovie, mockMovie))
        sut.stateMachine.onTransitionResult(onSuccess: { (_, newState, _) in
            XCTAssertEqual(newState, expected)
            XCTAssertEqual(newState.nowPlaying, self.mockMovie)
            XCTAssertEqual(newState.popular, self.mockMovie)
            XCTAssertEqual(newState.upcoming, self.mockMovie)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.1)
    }

    func testStateDidRequest() {
        sut.stateMachine = StateMachine(
            initialState: .isLoading,
            routing: MovieListViewModel.State.routes,
            effects: { [weak self] in
                self?.sut.effectHandler(effect: $0)
            })
        let expected = MovieListViewModel.State.isLoading
        let expectation = expectation(description: "State is requesting")

        sut.stateMachine.transition(.didRequest)
        sut.stateMachine.onTransitionResult(onSuccess: { (_, newState, _) in
            XCTAssertEqual(newState, expected)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.1)
    }

    func testStateDidReceiveError() {
        sut.stateMachine = StateMachine(
            initialState: .isLoading,
            routing: MovieListViewModel.State.routes,
            effects: { [weak self] in
                self?.sut.effectHandler(effect: $0)
            })
        let expected = MovieListViewModel.State.isLoading
        let expectation = expectation(description: "State is error when requesting")

        sut.stateMachine.transition(.didReceiveError)
        sut.stateMachine.onTransitionResult(onSuccess: nil) { err in
            XCTAssertEqual(err.currentState, expected)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testNavigateToDetail() {
        sut.navigateToDetail(movie: mockMovie.first!)
        XCTAssertTrue(mockRoute.isNavigate)
    }
}
