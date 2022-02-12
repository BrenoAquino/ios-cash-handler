//
//  OperationsRepositoryTests.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import XCTest
import Combine
import Domain

@testable import Data

class OperationsRepositoryTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = .init()
    
    func testAddOperationSuccessToDomainType() {
        XCTFail("Empty test")
    }

    func testAddOperationErrorToDomainType() {
        // Given
        let expectation = expectation(description: "error add operation")
        let remoteDataSource = MockErrorOperationsRemoteDataSource()
        let repository = OperationsRepositoryImpl(remoteDataSource: remoteDataSource)
        var error: Domain.CharlesError?

        // When
        repository
            .addOperation(title: "Title", date: "03/04/1997", value: 132, categoryId: 1, paymentTypeId: 2)
            .sinkCompletion { completion in
                switch completion {
                case .finished:
                    XCTFail("Must be an error")
                case .failure(let e):
                    error = e
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(error)
        XCTAssert(error?.type == .networkError)
    }
}
