//
//  ImpMovieRepositoryTests.swift
//  MovieDBTests
//
//  Created by William on 04/12/21.
//

import XCTest
import RxTest
import RxSwift
import RxBlocking
@testable import MovieDB

class ImpMovieRepositoryTests: XCTestCase {
    var network: MockNetworkRequest!
    var repository: ImpMovieRepository!
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        network = MockNetworkRequest()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()

        repository = ImpMovieRepository(networkRequest: network)
    }

    override func tearDown() {
        network = nil
        repository = nil
        super.tearDown()
    }

//    func test_getUpcomingMovie() {
//        let expected = scheduler.createObserver(MovieResultResponse.self)
//        expected.createColdObservable([
//            .next(5, nil),
//            .next(10, MovieResultResponse),
//        ])
//    }
}
