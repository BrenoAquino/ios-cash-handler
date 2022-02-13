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
        let localDataSource = MockPaymentMethodsLocalDataSource()
        let repository = PaymentMethodsRepositoryImpl(remoteDataSource: MockSuccessPaymentMethodsRemoteDataSource(),
                                                      localDataSource: localDataSource)
        var paymentMethods: [Domain.PaymentMethod]?
        
        // When
        repository
            .fetchPaymentMethods()
            .sink { completion in
                expectation.fulfill()
            } receiveValue: { value in
                paymentMethods = value
            }
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(paymentMethods)
        XCTAssert(paymentMethods?.count == 3)
        XCTAssert(paymentMethods?[0].id == 0)
        XCTAssert(paymentMethods?[1].name == "PaymentMethod1")
        XCTAssertNotNil(localDataSource.updatedPaymentMethods)
        XCTAssert(localDataSource.updatedPaymentMethods?.count == 3)
        XCTAssert(localDataSource.updatedPaymentMethods?[0].primaryKey == 0)
        XCTAssert(localDataSource.updatedPaymentMethods?[1].name == "PaymentMethod1")
    }
    
    func testPaymentMethodsErrorToDomainType() {
        // Given
        let expectation = expectation(description: "error fetch payment methods")
        let repository = PaymentMethodsRepositoryImpl(remoteDataSource: MockErrorPaymentMethodsRemoteDataSource(),
                                                      localDataSource: MockPaymentMethodsLocalDataSource())
        var error: Domain.CharlesError?
        
        // When
        repository
            .fetchPaymentMethods()
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
    
    // MARK: Cached Payment Methods
    func testCachedPaymentMethods() {
        // Given
        let repository = PaymentMethodsRepositoryImpl(remoteDataSource: MockSuccessPaymentMethodsRemoteDataSource(),
                                                      localDataSource: MockPaymentMethodsLocalDataSource())
        
        // When
        let paymentMethods = repository.cachedPaymentMethods()
        
        // Then
        XCTAssert(paymentMethods.count == 2)
        XCTAssert(paymentMethods[0].id == 0)
        XCTAssert(paymentMethods[1].name == "PaymentMethod1")
    }
}
