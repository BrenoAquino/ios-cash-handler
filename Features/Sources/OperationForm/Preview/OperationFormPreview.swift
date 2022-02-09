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
    func categories() -> AnyPublisher<[Domain.Category], CharlesError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func paymentMethods() -> AnyPublisher<[Domain.PaymentMethodDTO], CharlesError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func addOperation(title: String, date: Date, value: String, category: String, paymentType: String) -> AnyPublisher<Domain.Operation, CharlesError> {
        return Empty().eraseToAnyPublisher()
    }
}
#endif
