//
//  PaymentMethodsRemoteDataSource.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import XCTest
import Common
import Combine

@testable import Data

class PaymentMethodsRemoteDataSource: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: Tests
    func testPaymentMethodsSuccess() {
        // Given
        let expectation = expectation(description: "success payment methods")
        let sessionMock = URLSessionMock.success(file: .paymentMethodsSuccess)
        let remoteDataSource = PaymentMethodsRemoteDataSourceImpl(session: sessionMock, queue: .main)
        var paymentMethods: [PaymentMethodDTO]?
        
        // When
        remoteDataSource
            .paymentMethods()
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                paymentMethods = value
            }
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(paymentMethods)
        XCTAssert(paymentMethods?.count == 5)
        XCTAssert(paymentMethods?[0].id == 3)
        XCTAssert(paymentMethods?[0].name == "Vale Alimentação")
    }
    
    func testPaymentMethodsEcondingError() {
        // Given
        let expectation = expectation(description: "encoding error payment methods")
        let sessionMock = URLSessionMock.success(file: .paymentMethodsEncodingError)
        let remoteDataSource = PaymentMethodsRemoteDataSourceImpl(session: sessionMock, queue: .main)
        var error: CharlesDataError?
        
        // When
        remoteDataSource
            .paymentMethods()
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
    
    func testPaymentMethodsError() {
        // Given
        let expectation = expectation(description: "error add operation")
        let sessionMock = URLSessionMock.failure(statusCode: 500,
                                                 file: .paymentMethodsError,
                                                 error: CharlesDataError(type: .unkown))
        let remoteDataSource = PaymentMethodsRemoteDataSourceImpl(session: sessionMock, queue: .main)
        var error: CharlesDataError?
        
        // When
        remoteDataSource
            .paymentMethods()
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
