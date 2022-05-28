//
//  PaymentMethodsRemoteDataSourceTests.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import XCTest
import Common
import Combine

@testable import Data

class PaymentMethodsRemoteDataSourceTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: Payment Methods
    func testPaymentMethods() {
        // Given
        let expectation = expectation(description: "payment method")
        let networkProvider = TypeMockNetworkProvider()
        let remoteDataSource = PaymentMethodsRemoteDataSourceImpl(networkProvider: networkProvider)
        
        // When
        remoteDataSource
            .paymentMethods()
            .sinkCompletion { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(networkProvider.decodableType == [PaymentMethodDTO].self)
        XCTAssertEqual(networkProvider.api?.hashValue(), PaymentMethodsAPIs.paymentMethod.hashValue())
    }
    
    func testPaymentMethodsDecoding() {
        // Given
        let expectation = expectation(description: "decoding payment methods")
        let networkProvider = DecoderMockNetworkProvider(file: .paymentMethodsSuccess)
        let remoteDataSource = PaymentMethodsRemoteDataSourceImpl(networkProvider: networkProvider)
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
        XCTAssertEqual(paymentMethods?.count, 5)
        XCTAssertEqual(paymentMethods?[0].id, "0c1e0dc50d01c9111c308a1bade570345e232abc86d586fbecfb24262b568c50")
        XCTAssertEqual(paymentMethods?[0].name, "Vale Refeição")
        XCTAssertEqual(paymentMethods?[0].hasInstallments, false)
    }

    func testPaymentMethodsDecodingError() {
        // Given
        let expectation = expectation(description: "dencoding error payment methods")
        let networkProvider = DecoderMockNetworkProvider(file: .paymentMethodsDecodingError)
        let remoteDataSource = PaymentMethodsRemoteDataSourceImpl(networkProvider: networkProvider)
        var error: CharlesDataError?

        // When
        remoteDataSource
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
        waitForExpectations(timeout: .infinity, handler: nil)
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.type, .invalidDecoding)
    }
}
