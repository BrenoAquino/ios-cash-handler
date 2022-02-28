//
//  OperationsUseCasePreview.swift
//  
//
//  Created by Breno Aquino on 27/02/22.
//

#if DEBUG
import Foundation
import Combine
import Domain

// MARK: UseCase
class OperationsUseCasePreview: OperationsUseCase {
    func categories() -> [Domain.Category] {
        []
    }
    
    func paymentMethods() -> [Domain.PaymentMethod] {
        []
    }
    
    func operations() -> AnyPublisher<[Domain.Operation], CharlesError> {
        Empty().eraseToAnyPublisher()
    }
    
    func addOperation(title: String, date: Date, value: Double, categoryId: String, paymentMethodId: String) -> AnyPublisher<Domain.Operation, CharlesError> {
        Empty().eraseToAnyPublisher()
    }
}
#endif
