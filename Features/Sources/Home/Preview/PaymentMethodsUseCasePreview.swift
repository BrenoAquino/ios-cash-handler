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
class PaymentMethodsUseCasePreview: PaymentMethodsUseCase {
    func paymentMethods() -> AnyPublisher<[PaymentMethod], CharlesError> {
        return Just([
            Domain.PaymentMethod(id: "0", name: "Cartão de Crédito", hasInstallments: true),
            Domain.PaymentMethod(id: "1", name: "Transferência Bancária", hasInstallments: false)
        ])
            .setFailureType(to: CharlesError.self)
            .eraseToAnyPublisher()
    }
}
#endif
