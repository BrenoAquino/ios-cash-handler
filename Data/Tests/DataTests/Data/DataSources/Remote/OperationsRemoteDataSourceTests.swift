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
        .init(name: .empty, date: .empty, value: .zero, categoryId: .empty, paymentMethodId: .empty, installments: .one)
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
        XCTAssert(networkProvider.decodableType == [OperationDTO].self)
        XCTAssertEqual(networkProvider.api?.hashValue(), OperationsAPIs.addOperation(params: params).hashValue())
    }
    
    func testAddOperationDecoding() {
        // Given
        let expectation = expectation(description: "decoding add operation")
        let networkProvider = DecoderMockNetworkProvider(file: .addOperstionSuccess)
        let remoteDataSource = OperationsRemoteDataSourceImpl(networkProvider: networkProvider)
        var operations: [OperationDTO]?
        
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
                operations = value
            })
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(operations)
        XCTAssertEqual(operations?.count, 1)
        XCTAssertEqual(operations?[0].name, "Madero")
        XCTAssertEqual(operations?[0].date, "20-12-2022")
        XCTAssertEqual(operations?[0].categoryId, "1")
        XCTAssertEqual(operations?[0].paymentMethodId, "1")
        XCTAssertEqual(operations?[0].value, 123.123)
        XCTAssertNil(operations?[0].currentInstallments)
        XCTAssertNil(operations?[0].totalInstallments)
        XCTAssertNil(operations?[0].operationAggregatorId)
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
        XCTAssertEqual(error?.type, .invalidDecoding)
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
        XCTAssertEqual(networkProvider.api?.hashValue(), OperationsAPIs.operations.hashValue())
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
        XCTAssertEqual(operations?.count, 4)
        XCTAssertEqual(operations?[0].id, "d225928d-6701-4870-acb6-80313818c41b")
        XCTAssertEqual(operations?[0].name, "Roupas")
        XCTAssertEqual(operations?[0].date, "03-04-2022")
        XCTAssertEqual(operations?[0].categoryId, "d738b05e792cf0108226b0f8a128e0a9203b859ab55c66fce4a4f480463ea328")
        XCTAssertEqual(operations?[0].paymentMethodId, "60d5dbad6a8db5f7f37eba1733a3e654e71350d36c7321c73c5d8d6a37b71d22")
        XCTAssertEqual(operations?[0].value, 192.14)
        XCTAssertEqual(operations?[0].currentInstallments, 2)
        XCTAssertEqual(operations?[0].totalInstallments, 2)
        XCTAssertEqual(operations?[0].operationAggregatorId, "f1aa8034-a788-48f7-9f70-c086e962a8db")
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
        XCTAssertEqual(error?.type, .invalidDecoding)
    }
}
