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
    
    // MARK: Payment Methods
    func testPaymentMethods() {
        // Given
        let expectation = expectation(description: "payment method")
        let networkProvider = TypeMockNetworkProvider()
        let remoteDataSource = PaymentMethodsRemoteDataSourceImpl(networkProvider: networkProvider)
        
        // When
        _ = remoteDataSource
            .paymentMethods()
            .sinkCompletion { _ in
                expectation.fulfill()
            }
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(networkProvider.decodableType == [PaymentMethodDTO].self)
        XCTAssert(networkProvider.api?.hashValue() == PaymentMethodsAPIs.paymentMethod.hashValue())
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
        XCTAssert(paymentMethods?.count == 5)
        XCTAssert(paymentMethods?[0].id == 3)
        XCTAssert(paymentMethods?[0].name == "Vale Alimentação")
    }

    func testPaymentMethodsDecondingError() {
        // Given
        let expectation = expectation(description: "dencoding error payment methods")
        let networkProvider = DecoderMockNetworkProvider(file: .paymentMethodsEncodingError)
        let remoteDataSource = PaymentMethodsRemoteDataSourceImpl(networkProvider: networkProvider)
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
}
