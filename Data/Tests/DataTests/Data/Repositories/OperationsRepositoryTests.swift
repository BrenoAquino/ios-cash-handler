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
        // Given
        let expectation = expectation(description: "success add operation")
        let repository = OperationsRepositoryImpl(remoteDataSource: MockSuccessOperationsRemoteDataSource(),
                                                  paymentMethodsLocalDataSource: MockPaymentMethodsLocalDataSource(),
                                                  categoriesLocalDataSource: MockCategoriesLocalDataSource())
        var operation: Domain.Operation?
        
        // When
        repository
            .addOperation(title: "Title", date: "03/04/1997", value: 132, categoryId: 0, paymentTypeId: 1)
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                operation = value
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(operation)
        XCTAssert(operation?.id == "123")
        XCTAssert(operation?.title == "Title")
        XCTAssert(operation?.value == 132)
        XCTAssert(operation?.date == Date.components(day: 3, month: 4, year: 1997))
        XCTAssert(operation?.category.id == 0)
        XCTAssert(operation?.category.name == "Category0")
        XCTAssert(operation?.paymentMethod.id == 1)
        XCTAssert(operation?.paymentMethod.name == "PaymentMethod1")
    }
    
    func testAddOperationSuccessToDomainWithConverterError() {
        // Given
        let expectation = expectation(description: "success add operation")
        let repository = OperationsRepositoryImpl(remoteDataSource: MockSuccessOperationsRemoteDataSource(),
                                                  paymentMethodsLocalDataSource: MockPaymentMethodsLocalDataSource(paymentMethods: []),
                                                  categoriesLocalDataSource: MockCategoriesLocalDataSource(categories: []))
        var error: Domain.CharlesError?
        
        // When
        repository
            .addOperation(title: "Title", date: "03/04/1997", value: 132, categoryId: 0, paymentTypeId: 1)
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

    func testAddOperationErrorToDomainType() {
        // Given
        let expectation = expectation(description: "error add operation")
        let repository = OperationsRepositoryImpl(remoteDataSource: MockErrorOperationsRemoteDataSource(),
                                                  paymentMethodsLocalDataSource: MockPaymentMethodsLocalDataSource(),
                                                  categoriesLocalDataSource: MockCategoriesLocalDataSource())
        var error: Domain.CharlesError?

        // When
        repository
            .addOperation(title: "Title", date: "03/04/1997", value: 132, categoryId: 0, paymentTypeId: 1)
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
