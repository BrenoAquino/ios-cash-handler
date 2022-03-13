//
//  PaymentMethodsUseCase.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Combine

public protocol PaymentMethodsUseCase {
    func paymentMethods() -> AnyPublisher<[PaymentMethod], CharlesError>
    func cachedPaymentMethods() -> [PaymentMethod]
}

// MARK: Implementation
public final class PaymentMethodsUseCaseImpl {
    
    private let paymentMethodsRepository: PaymentMethodsRepository
    
    public init(paymentMethodsRepository: PaymentMethodsRepository) {
        self.paymentMethodsRepository = paymentMethodsRepository
    }
}

// MARK: Interfaces
extension PaymentMethodsUseCaseImpl: PaymentMethodsUseCase {
    public func cachedPaymentMethods() -> [PaymentMethod] {
        return paymentMethodsRepository
            .cachedPaymentMethods()
    }
    
    public func paymentMethods() -> AnyPublisher<[PaymentMethod], CharlesError> {
        return paymentMethodsRepository
            .fetchPaymentMethods()
            .map { $0.sorted(by: { $0.name < $1.name }) }
            .eraseToAnyPublisher()
    }
}
