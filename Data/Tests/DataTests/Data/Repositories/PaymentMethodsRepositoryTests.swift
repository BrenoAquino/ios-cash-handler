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
        let remoteDataSource = MockSuccessPaymentMethodsRemoteDataSource()
        let repository = PaymentMethodsRepositoryImpl(remoteDataSource: remoteDataSource)
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
    }
    
    func testPaymentMethodsErrorToDomainType() {
        // Given
        let expectation = expectation(description: "error fetch payment methods")
        let remoteDataSource = MockErrorPaymentMethodsRemoteDataSource()
        let repository = PaymentMethodsRepositoryImpl(remoteDataSource: remoteDataSource)
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
}
