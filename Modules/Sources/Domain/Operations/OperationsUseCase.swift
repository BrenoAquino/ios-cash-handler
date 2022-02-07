//
//  OperationsUseCase.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine

public protocol OperationsUseCase {
    func addOperation(title: String,
                      date: String,
                      value: Double,
                      category: String,
                      paymentType: String,
                      operationType: OperationType) -> AnyPublisher<Operation, CharlesError>
}

// MARK: Implementation
public final class OperationsUseCaseImpl {
    
    private let operationsRepository: OperationsRepository
    
    public init(operationsRepository: OperationsRepository) {
        self.operationsRepository = operationsRepository
    }
}

// MARK: Interfaces
extension OperationsUseCaseImpl: OperationsUseCase {
    public func addOperation(title: String,
                             date: String,
                             value: Double,
                             category: String,
                             paymentType: String,
                             operationType: OperationType) -> AnyPublisher<Operation, CharlesError> {
        return operationsRepository
            .addOperation(title: title,
                          date: date,
                          value: value,
                          category: category,
                          paymentType: paymentType,
                          operationType: operationType.rawValue)
    }
}
