//
//  NetworkRequestTests.swift
//  MovieDBTests
//
//  Created by William on 04/12/21.
//

import XCTest
import RxTest
import RxSwift
import RxBlocking

@testable import MovieDB
class NetworkRequestTests: XCTestCase {
    var session: MockSessionRequest!
    var network: NetworkSessionRequest!

    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()

        session = MockSessionRequest()
        network = NetworkSessionRequest(session)

        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        session = nil
        super.tearDown()
    }

    func test_successRequest() {
//        network.request(<#T##url: URLRequestConvertible##URLRequestConvertible#>, decodable: <#T##(Decodable & Encodable).Protocol#>)
    }
}
