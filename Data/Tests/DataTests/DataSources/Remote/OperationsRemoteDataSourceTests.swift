//
//  OperationsRemoteDataSourceTests.swift
//  
//
//  Created by Breno Aquino on 06/02/22.
//

import XCTest
import Common
import Combine

@testable import Data

class OperationsRemoteDataSourceTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = .init()
    var params: CreateOperationParams {
        .init(title: .empty, date: .empty, value: .zero, categoryId: .zero, paymentMethodId: .zero)
    }
    
    // MARK: Tests
    func testAddOperationSuccess() {
        // Given
        let expectation = expectation(description: "success add operation")
        let sessionMock = URLSessionMock.success(file: .addOperstionSuccess)
        let remoteDataSource = OperationsRemoteDataSourceImpl(session: sessionMock, queue: .main)
        var operation: OperationDTO?
        
        // When
        remoteDataSource
            .addOperation(params: params)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Error Code: \(error.type.rawValue)")
                }
            }, receiveValue: { value in
                operation = value
            })
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(operation)
        XCTAssert(operation?.title == "Madero")
        XCTAssert(operation?.date == "20-12-2022")
        XCTAssert(operation?.categoryId == 1)
        XCTAssert(operation?.paymentMethodId == 1)
        XCTAssert(operation?.value == 123.123)
    }
    
    func testAddOperationEcondingError() {
        // Given
        let expectation = expectation(description: "encoding error add operation")
        let sessionMock = URLSessionMock.success(file: .addOperstionEncodingError)
        let remoteDataSource = OperationsRemoteDataSourceImpl(session: sessionMock, queue: .main)
        var error: CharlesDataError?
        
        // When
        remoteDataSource
            .addOperation(params: params)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Must be an error")
                case .failure(let e):
                    error = e
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: .infinity, handler: nil)
        XCTAssertNotNil(error)
        XCTAssert(error?.type == .invalidDecoding)
    }
    
    func testAddOperationError() {
        // Given
        let expectation = expectation(description: "error add operation")
        let sessionMock = URLSessionMock.failure(statusCode: 500,
                                                 file: .addOperstionEncodingError,
                                                 error: CharlesDataError(type: .unkown))
        let remoteDataSource = OperationsRemoteDataSourceImpl(session: sessionMock, queue: .main)
        var error: CharlesDataError?
        
        // When
        remoteDataSource
            .addOperation(params: params)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Must be an error")
                case .failure(let e):
                    error = e
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(error)
        XCTAssert(error?.type == .unkown)
    }
}
