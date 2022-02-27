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
        .init(title: .empty, date: .empty, value: .zero, categoryId: .empty, paymentMethodId: .empty)
    }
    
    // MARK: Add Operation
    func testAddOperation() {
        // Given
        let expectation = expectation(description: "add operation")
        let networkProvider = TypeMockNetworkProvider()
        let remoteDataSource = OperationsRemoteDataSourceImpl(networkProvider: networkProvider)
        
        // When
        _ = remoteDataSource
            .addOperation(params: params)
            .sinkCompletion { _ in
                expectation.fulfill()
            }
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(networkProvider.decodableType == OperationDTO.self)
        XCTAssert(networkProvider.api?.hashValue() == OperationsAPIs.addOperation(params: params).hashValue())
    }
    
    func testAddOperationDecoding() {
        // Given
        let expectation = expectation(description: "decoding add operation")
        let networkProvider = DecoderMockNetworkProvider(file: .addOperstionSuccess)
        let remoteDataSource = OperationsRemoteDataSourceImpl(networkProvider: networkProvider)
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
        XCTAssert(operation?.categoryId == "1")
        XCTAssert(operation?.paymentMethodId == "1")
        XCTAssert(operation?.value == 123.123)
    }
    
    func testAddOperationDecodingError() {
        // Given
        let expectation = expectation(description: "decoding error add operation")
        let networkProvider = DecoderMockNetworkProvider(file: .addOperstionDecodingError)
        let remoteDataSource = OperationsRemoteDataSourceImpl(networkProvider: networkProvider)
        var error: CharlesDataError?

        // When
        remoteDataSource
            .addOperation(params: params)
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
        waitForExpectations(timeout: .infinity, handler: nil)
        XCTAssertNotNil(error)
        XCTAssert(error?.type == .invalidDecoding)
    }
    
    // MARK: Operations
    func testOperations() {
        // Given
        let expectation = expectation(description: "operations")
        let networkProvider = TypeMockNetworkProvider()
        let remoteDataSource = OperationsRemoteDataSourceImpl(networkProvider: networkProvider)
        
        // When
        _ = remoteDataSource
            .operations()
            .sinkCompletion { _ in
                expectation.fulfill()
            }
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(networkProvider.decodableType == [OperationDTO].self)
        XCTAssert(networkProvider.api?.hashValue() == OperationsAPIs.operations.hashValue())
    }
    
    func testOperationsDecoding() {
        // Given
        let expectation = expectation(description: "decoding operations")
        let networkProvider = DecoderMockNetworkProvider(file: .operationsSuccess)
        let remoteDataSource = OperationsRemoteDataSourceImpl(networkProvider: networkProvider)
        var operations: [OperationDTO]?
        
        // When
        remoteDataSource
            .operations()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Error Code: \(error.type.rawValue)")
                }
            }, receiveValue: { value in
                operations = value
            })
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(operations)
        XCTAssert(operations?.count == 3)
        XCTAssert(operations?[0].id == "980c5695-5411-4de0-8fa6-a80b8b3a8e33")
        XCTAssert(operations?[0].title == "Madero")
        XCTAssert(operations?[0].date == "20-12-2022")
        XCTAssert(operations?[0].categoryId == "521bac2c00686155bc874aac9c83650c2201140d13c14db953251b635bcc25cb")
        XCTAssert(operations?[0].paymentMethodId == "0c1e0dc50d01c9111c308a1bade570345e232abc86d586fbecfb24262b568c50")
        XCTAssert(operations?[0].value == 123.123)
    }
    
    func testOperationsDecodingError() {
        // Given
        let expectation = expectation(description: "decoding error operations")
        let networkProvider = DecoderMockNetworkProvider(file: .operationsDecodingError)
        let remoteDataSource = OperationsRemoteDataSourceImpl(networkProvider: networkProvider)
        var error: CharlesDataError?

        // When
        remoteDataSource
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
        waitForExpectations(timeout: .infinity, handler: nil)
        XCTAssertNotNil(error)
        XCTAssert(error?.type == .invalidDecoding)
    }
}
