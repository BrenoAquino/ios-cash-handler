//
//  OperationsUseCase.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine
import Common

public protocol OperationsUseCase {
    func addOperation(title: String,
                      date: Date,
                      value: String,
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
                             date: Date,
                             value: String,
                             category: String,
                             paymentType: String,
                             operationType: OperationType) -> AnyPublisher<Operation, CharlesError> {
        guard let value = Double(value) else {
            return Fail(error: CharlesError(type: .unkown))
                .eraseToAnyPublisher()
        }
        
        let dateFormatted = DateFormatter(pattern: "dd-MM-yyyy")
        return operationsRepository
            .addOperation(title: title,
                          date: dateFormatted.string(from: date),
                          value: value,
                          category: category,
                          paymentType: paymentType,
                          operationType: operationType.rawValue)
    }
}
