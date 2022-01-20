//
//  OperationsUseCase.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine

protocol OperationsUseCase {
    func addOperation(title: String,
                      date: String,
                      value: Double,
                      category: String,
                      paymentType: String,
                      operationType: OperationType) -> AnyPublisher<Operation, Error>
}

// MARK: Implementation
final class OperationsUseCaseImpl {
    
    private let operationsRepository: OperationsRepository
    
    init(operationsRepository: OperationsRepository) {
        self.operationsRepository = operationsRepository
    }
}

// MARK: Interfaces
extension OperationsUseCaseImpl {
    func addOperation(title: String,
                      date: String,
                      value: Double,
                      category: String,
                      paymentType: String,
                      operationType: OperationType) -> AnyPublisher<Operation, Error> {
        return operationsRepository.addOperation(title: title,
                                          date: date,
                                          value: value,
                                          category: category,
                                          paymentType: paymentType,
                                          operationType: operationType.rawValue)
    }
}
