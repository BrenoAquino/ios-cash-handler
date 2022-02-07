//
//  OperationsRemoteDataSourceTests.swift
//  
//
//  Created by Breno Aquino on 06/02/22.
//

import XCTest
import Common
import Combine
import Domain

@testable import Data

class OperationsRemoteDataSourceTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: Tests
    func testAddOperationSuccess() {
        // Given
        let expectation = expectation(description: "success add operation")
        let sessionMock = URLSessionMock.success(file: .addOperstionSuccess)
        let remoteDataSource = OperationsRemoteDataSourceImpl(session: sessionMock, queue: .main)
        
        // When
        remoteDataSource
            .addOperation(params: .init(title: .empty, date: .empty, value: .zero, category: .empty, paymentMethod: .empty))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Error Code: \(error.type.rawValue)")
                }
            }, receiveValue: { operation in
                XCTAssert(operation.title == "Madero")
                XCTAssert(operation.date == "20-12-2022")
                XCTAssert(operation.category == "leisure")
                XCTAssert(operation.paymentMethod == "credit-card")
                XCTAssert(operation.value == 123.123)
            })
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAddOperationEcondingError() {
        // Given
        let expectation = expectation(description: "encoding error add operation")
        let sessionMock = URLSessionMock.success(file: .addOperstionEncodingError)
        let remoteDataSource = OperationsRemoteDataSourceImpl(session: sessionMock, queue: .main)
        
        // When
        remoteDataSource
            .addOperation(params: .init(title: .empty, date: .empty, value: .zero, category: .empty, paymentMethod: .empty))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Must be an error")
                case .failure(let error):
                    XCTAssert(error.type == .invalidDecoding)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: .infinity, handler: nil)
    }
    
    func testAddOperationError() {
        // Given
        let expectation = expectation(description: "error add operation")
        let sessionMock = URLSessionMock.failure(statusCode: 500, file: .addOperstionEncodingError, error: CharlesError(type: .unkown))
        let remoteDataSource = OperationsRemoteDataSourceImpl(session: sessionMock, queue: .main)
        
        // When
        remoteDataSource
            .addOperation(params: .init(title: .empty, date: .empty, value: .zero, category: .empty, paymentMethod: .empty))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Must be an error")
                case .failure(let error):
                    XCTAssert(error.type == .unkown)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
    }
}
