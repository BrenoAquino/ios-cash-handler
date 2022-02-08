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
    func addOperation(title: String,
                      date: Date,
                      value: String,
                      category: String,
                      paymentType: String,
                      operationType: OperationType) -> AnyPublisher<Domain.Operation, Domain.CharlesError> {
        return Empty()
            .eraseToAnyPublisher()
    }
}
#endif
