//
//  OperationFormPreview.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

#if DEBUG
import Foundation
import Combine
import Domain

// MARK: UseCase
class OperationsUseCaseMock: OperationsUseCase {
    func categories() -> [Domain.Category] {
        return []
    }
    
    func paymentMethods() -> [Domain.PaymentMethod] {
        return []
    }
    
    func operations() -> AnyPublisher<[Domain.Operation], CharlesError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func addOperation(title: String, date: Date, value: Double, categoryId: String, paymentMethodId: String) -> AnyPublisher<Domain.Operation, CharlesError> {
        return Empty().eraseToAnyPublisher()
    }
}
#endif
