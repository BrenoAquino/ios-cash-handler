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
        return Empty().eraseToAnyPublisher()
    }
}
#endif
