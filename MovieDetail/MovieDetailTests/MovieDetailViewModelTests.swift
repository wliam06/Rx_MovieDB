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
    var viewModel: MovieDetailViewModel!
    var usecase: MockMovieDetailUseCase!
    var mock: MockMovieDetailModel!

    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()

        viewModel = MovieDetailViewModel(1)
        usecase = MockMovieDetailUseCase()
        mock = MockMovieDetailModel()
        viewModel.usecase = usecase
    }

    override func tearDown() {
        viewModel = nil
        usecase = nil
        mock = nil
        super.tearDown()
    }

    func testSuccessDidLoad() {
        usecase.stubbedFetchMovieDetailResult = .just(mock.result())
        viewModel.didLoad()
        _ = usecase.fetchMovieDetail(id: 1)
        XCTAssertTrue(usecase.invokedFetchMovieDetail)
        XCTAssertEqual(viewModel.movie.count, 1)
    }

    func testErrorGetMovieDetail() {
        usecase.stubbedFetchMovieDetailResult = .error(MockErrorResponse.someError)
        viewModel.didLoad()
        _ = usecase.fetchMovieDetail(id: 1)
        XCTAssertTrue(usecase.invokedFetchMovieDetail)
        XCTAssertEqual(viewModel.movie.count, 0)
    }

    func testClearMovieDetail() {
        viewModel.didDisappear()
        XCTAssertEqual(viewModel.movie.count, 0)
    }
}

