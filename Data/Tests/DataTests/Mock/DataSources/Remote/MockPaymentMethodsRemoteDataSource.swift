//
//  MockPaymentMethodsRemoteDataSource.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

import Foundation
import Combine

@testable import Data

class MockSuccessPaymentMethodsRemoteDataSource: PaymentMethodsRemoteDataSource {
    
    func paymentMethods() -> AnyPublisher<[PaymentMethodDTO], CharlesDataError> {
        let paymentMethods: [PaymentMethodDTO] = [
            .init(id: 0, name: "PaymentMethod0"),
            .init(id: 1, name: "PaymentMethod1"),
            .init(id: 2, name: "PaymentMethod2")
        ]
        return Just(paymentMethods)
            .setFailureType(to: CharlesDataError.self)
            .eraseToAnyPublisher()
    }
}

class MockErrorPaymentMethodsRemoteDataSource: PaymentMethodsRemoteDataSource {
    
    func paymentMethods() -> AnyPublisher<[PaymentMethodDTO], CharlesDataError> {
        let error = CharlesDataError(type: .badRequest)
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
}
