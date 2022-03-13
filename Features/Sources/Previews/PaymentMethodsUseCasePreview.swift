//
//  PaymentMethodsUseCasePreview.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

#if DEBUG
import Foundation
import Combine
import Domain

// MARK: UseCase
public class PaymentMethodsUseCasePreview: PaymentMethodsUseCase {
    private let paymentMethodsArray: [PaymentMethod] = [
        Domain.PaymentMethod(id: "0", name: "Cartão de Crédito", hasInstallments: true),
        Domain.PaymentMethod(id: "1", name: "Transferência Bancária", hasInstallments: false)
    ]
    
    public init() {}
    
    public func cachedPaymentMethods() -> [PaymentMethod] {
        paymentMethodsArray
    }
    
    public func paymentMethods() -> AnyPublisher<[PaymentMethod], CharlesError> {
        return Just(paymentMethodsArray)
            .setFailureType(to: CharlesError.self)
            .eraseToAnyPublisher()
    }
}
#endif
