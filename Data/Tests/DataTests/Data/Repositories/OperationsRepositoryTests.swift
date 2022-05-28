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
    var params: Domain.CreateOperation {
        .init(name: "Title",
              date: "1997-04-03",
              value: 132,
              categoryId: "0",
              paymentMethodId: "0",
              installments: nil)
    }
    var categories: [Domain.Category] {
        [ Category(id: "0", name: "Tech") ]
    }
    var paymentMethods: [Domain.PaymentMethod] {
        [ PaymentMethod(id: "0", name: "Credit Card", hasInstallments: true) ]
    }
    
    // MARK: Add Operations
    func testAddOperationSuccessToDomainType() {
        // Given
        let expectation = expectation(description: "success add operation")
        let repository = OperationsRepositoryImpl(remoteDataSource: MockSuccessOperationsRemoteDataSource())
        var operations: [Domain.Operation]?
        
        // When
        repository
            .addOperation(createOperation: params,
                          categories: categories,
                          paymentMethods: paymentMethods)
            .sink { completion in
                print(completion)
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
        XCTAssertEqual(operations?[0].category.name, "Tech")
        XCTAssertEqual(operations?[0].paymentMethod.id, "0")
        XCTAssertEqual(operations?[0].paymentMethod.name, "Credit Card")
    }
    
    func testAddOperationSuccessToDomainWithConverterError() {
        // Given
        let expectation = expectation(description: "converter error add operation")
        let repository = OperationsRepositoryImpl(remoteDataSource: MockSuccessOperationsRemoteDataSource())
        var error: Domain.CharlesError?
        
        // When
        repository
            .addOperation(createOperation: params,
                          categories: [],
                          paymentMethods: [])
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
        XCTAssertEqual(error?.type, .invalidConvertion)
    }

    func testAddOperationErrorToDomainType() {
        // Given
        let expectation = expectation(description: "error add operation")
        let repository = OperationsRepositoryImpl(remoteDataSource: MockErrorOperationsRemoteDataSource())
        var error: Domain.CharlesError?

        // When
        repository
            .addOperation(createOperation: params,
                          categories: categories,
                          paymentMethods: paymentMethods)
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
        let repository = OperationsRepositoryImpl(remoteDataSource: MockSuccessOperationsRemoteDataSource())
        var operations: [Domain.Operation]?
        
        // When
        repository
            .operations(categories: categories, paymentMethods: paymentMethods)
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                operations = value
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        let formatter = DateFormatter(pattern: "yyyy-MM-dd")
        XCTAssertNotNil(operations)
        XCTAssertEqual(operations?.count, 1)
        XCTAssertEqual(operations?[0].id, "123")
        XCTAssertEqual(operations?[0].name, "title")
        XCTAssertEqual(operations?[0].value, 123)
        XCTAssertEqual(formatter.string(from: operations![0].date), "2022-01-01")
        XCTAssertEqual(operations?[0].category.id, "0")
        XCTAssertEqual(operations?[0].category.name, "Tech")
        XCTAssertEqual(operations?[0].paymentMethod.id, "0")
        XCTAssertEqual(operations?[0].paymentMethod.name, "Credit Card")
    }
    
    func testOperationsSuccessToDomainWithConverterError() {
        // Given
        let expectation = expectation(description: "converter error operations")
        let repository = OperationsRepositoryImpl(remoteDataSource: MockSuccessOperationsRemoteDataSource())
        var error: Domain.CharlesError?
        
        // When
        repository
            .operations(categories: [], paymentMethods: [])
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
        XCTAssertEqual(error?.type, .invalidConvertion)
    }

    func testOperationsErrorToDomainType() {
        // Given
        let expectation = expectation(description: "error operations")
        let repository = OperationsRepositoryImpl(remoteDataSource: MockErrorOperationsRemoteDataSource())
        var error: Domain.CharlesError?

        // When
        repository
            .operations(categories: categories, paymentMethods: paymentMethods)
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
