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
    let params: CreateOperation = .init(
        name: "Title",
        date: "03/04/1997",
        value: 132,
        categoryId: "0",
        paymentMethodId: "1",
        installments: nil
    )
    
    // MARK: Add Operations
    func testAddOperationSuccessToDomainType() {
        // Given
        let expectation = expectation(description: "success add operation")
        let repository = OperationsRepositoryImpl(remoteDataSource: MockSuccessOperationsRemoteDataSource(),
                                                  paymentMethodsLocalDataSource: MockPaymentMethodsLocalDataSource(),
                                                  categoriesLocalDataSource: MockCategoriesLocalDataSource())
        var operations: [Domain.Operation]?
        
        // When
        repository
            .addOperation(createOperation: params)
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                operations = value
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(operations)
        XCTAssertEqual(operations?.count, 1)
        XCTAssertEqual(operations?[0].id, "123")
        XCTAssertEqual(operations?[0].name, "Title")
        XCTAssertEqual(operations?[0].value, 132)
        XCTAssertEqual(operations?[0].date, Date.components(day: 3, month: 4, year: 1997))
        XCTAssertEqual(operations?[0].category.id, "0")
        XCTAssertEqual(operations?[0].category.name, "Category0")
        XCTAssertEqual(operations?[0].paymentMethod.id, "1")
        XCTAssertEqual(operations?[0].paymentMethod.name, "PaymentMethod1")
    }
    
    func testAddOperationSuccessToDomainWithConverterError() {
        // Given
        let expectation = expectation(description: "converter error add operation")
        let repository = OperationsRepositoryImpl(remoteDataSource: MockSuccessOperationsRemoteDataSource(),
                                                  paymentMethodsLocalDataSource: MockPaymentMethodsLocalDataSource(paymentMethods: []),
                                                  categoriesLocalDataSource: MockCategoriesLocalDataSource(categories: []))
        var error: Domain.CharlesError?
        
        // When
        repository
            .addOperation(createOperation: params)
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
        XCTAssertEqual(error?.type, .networkError)
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
            .addOperation(createOperation: params)
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
        XCTAssertEqual(error?.type, .networkError)
    }
    
    // MARK: Operations
    func testOperationsSuccessToDomainType() {
        // Given
        let expectation = expectation(description: "success operations")
        let repository = OperationsRepositoryImpl(remoteDataSource: MockSuccessOperationsRemoteDataSource(),
                                                  paymentMethodsLocalDataSource: MockPaymentMethodsLocalDataSource(),
                                                  categoriesLocalDataSource: MockCategoriesLocalDataSource())
        var operations: [Domain.Operation]?
        
        // When
        repository
            .operations()
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                operations = value
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(operations)
        XCTAssertEqual(operations?.count, 1)
        XCTAssertEqual(operations?[0].id, "123")
        XCTAssertEqual(operations?[0].name, "title")
        XCTAssertEqual(operations?[0].value, 123)
        XCTAssertEqual(operations?[0].date, Date.components(day: 1, month: 1, year: 2000))
        XCTAssertEqual(operations?[0].category.id, "0")
        XCTAssertEqual(operations?[0].category.name, "Category0")
        XCTAssertEqual(operations?[0].paymentMethod.id, "0")
        XCTAssertEqual(operations?[0].paymentMethod.name, "PaymentMethod0")
    }
    
    func testOperationsSuccessToDomainWithConverterError() {
        // Given
        let expectation = expectation(description: "converter error operations")
        let repository = OperationsRepositoryImpl(remoteDataSource: MockSuccessOperationsRemoteDataSource(),
                                                  paymentMethodsLocalDataSource: MockPaymentMethodsLocalDataSource(paymentMethods: []),
                                                  categoriesLocalDataSource: MockCategoriesLocalDataSource(categories: []))
        var error: Domain.CharlesError?
        
        // When
        repository
            .operations()
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
        XCTAssertEqual(error?.type, .networkError)
    }

    func testOperationsErrorToDomainType() {
        // Given
        let expectation = expectation(description: "error operations")
        let repository = OperationsRepositoryImpl(remoteDataSource: MockErrorOperationsRemoteDataSource(),
                                                  paymentMethodsLocalDataSource: MockPaymentMethodsLocalDataSource(),
                                                  categoriesLocalDataSource: MockCategoriesLocalDataSource())
        var error: Domain.CharlesError?

        // When
        repository
            .operations()
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
        XCTAssertEqual(error?.type, .networkError)
    }
}
