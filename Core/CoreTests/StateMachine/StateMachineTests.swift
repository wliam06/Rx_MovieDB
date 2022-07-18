//
//  StateMachineTests.swift
//  CoreTests
//
//  Created by William on 18/07/22.
//

import XCTest
@testable import Core

class StateMachineTests: XCTestCase {
    var sut: MockImpStateMachine!
    let idRequest = "1"

    override func setUp() {
        super.setUp()
        sut = MockImpStateMachine()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testOnStarting() {
        sut.stubbedStateMachine = StateMachine(
            initialState: .starting,
            routing: MockImpStateMachine.State.routes,
            effects: { [weak self] in
                self?.sut.effectHandler(effect: $0)
            }
        )

        let expected = MockImpStateMachine.State.starting
        sut.stateMachine.transition(.didLoading(idRequest))

        let expectation = expectation(description: "State is starting")
        sut.stateMachine.onTransitionResult(onSuccess: { (_, newState, _) in
            XCTAssertEqual(newState, expected)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.1)
    }

    func testSuccessRequesting() {
        sut.stubbedStateMachine = StateMachine(
            initialState: .request,
            routing: MockImpStateMachine.State.routes,
            effects: { [weak self] in
                self?.sut.effectHandler(effect: $0)
            }
        )

        let expected = MockImpStateMachine.State.stop
        sut.stateMachine.transition(.didSuccess(idRequest))

        let expectation = expectation(description: "State is success requesting and stopped")
        sut.stateMachine.onTransitionResult(onSuccess: { (_, newState, _) in
            XCTAssertEqual(newState, expected)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.1)
    }

    func testFailureTransition() {
        sut.stubbedStateMachine = StateMachine(
            initialState: .request,
            routing: MockImpStateMachine.State.routes,
            effects: { [weak self] in
                self?.sut.effectHandler(effect: $0)
            }
        )

        sut.onRequestAPI(id: idRequest)
        sut.stateMachine.transition(.didFailure)
        let expected = MockImpStateMachine.State.request
        let expectation = expectation(description: "Stae is request but connection fail")
        sut.stateMachine.onTransitionResult(onSuccess: { (_, newState, _) in
        }, onFailure: { (err) in
            XCTAssertEqual(err.currentState, expected)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.1)
    }
}
