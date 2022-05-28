//
//  PaymentMethodsRepositoryTests.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import XCTest
import Combine
import Domain

@testable import Data

class PaymentMethodsRepositoryTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: Payment Methods
    func testPaymentMethodsSuccessToDomainType() {
        // Given
        let expectation = expectation(description: "success fetch payment methods")
        let localDataSource = MockPaymentMethodsLocalDataSource(paymentMethods: [])
        let remoteDataSource = MockSuccessPaymentMethodsRemoteDataSource()
        let repository = PaymentMethodsRepositoryImpl(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        var paymentMethods: [Domain.PaymentMethod]?
        
        // When
        repository
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
        XCTAssertEqual(paymentMethods?.count, 3)
        XCTAssertEqual(paymentMethods?[0].id, "0")
        XCTAssertEqual(paymentMethods?[1].name, "PaymentMethod1")
        XCTAssertNotNil(localDataSource.updatedPaymentMethods)
        XCTAssertEqual(localDataSource.updatedPaymentMethods?.count, 3)
        XCTAssertEqual(localDataSource.updatedPaymentMethods?[0].primaryKey, "0")
        XCTAssertEqual(localDataSource.updatedPaymentMethods?[1].name, "PaymentMethod1")
    }
    
    func testPaymentMethodsWithLocalContent() {
        // Given
        let expectation = expectation(description: "success fetch from cache")
        let remoteDataSource = MockErrorPaymentMethodsRemoteDataSource()
        let localDataSource = MockPaymentMethodsLocalDataSource()
        let repository = PaymentMethodsRepositoryImpl(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        var paymentMethods: [Domain.PaymentMethod]?
        
        // When
        repository
            .paymentMethods()
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                paymentMethods = value
            }
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(paymentMethods?.count, 2)
    }
    
    func testPaymentMethodsErrorToDomainType() {
        // Given
        let expectation = expectation(description: "error fetch payment methods")
        let repository = PaymentMethodsRepositoryImpl(remoteDataSource: MockErrorPaymentMethodsRemoteDataSource(),
                                                      localDataSource: MockPaymentMethodsLocalDataSource(paymentMethods: []))
        var error: Domain.CharlesError?
        
        // When
        repository
            .paymentMethods()
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
