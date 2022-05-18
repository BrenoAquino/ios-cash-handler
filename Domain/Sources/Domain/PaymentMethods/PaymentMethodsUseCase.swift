//
//  PaymentMethodsUseCase.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Combine
import Common

public protocol PaymentMethodsUseCase {
    func paymentMethods() -> AnyPublisher<[PaymentMethod], CharlesError>
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
    public func paymentMethods() -> AnyDataPubliher<[PaymentMethod], CharlesError> {
        return paymentMethodsRepository
            .paymentMethods()
            .map { $0.sorted(by: { $0.name < $1.name }) }
            .eraseToAnyPublisher()
    }
}
