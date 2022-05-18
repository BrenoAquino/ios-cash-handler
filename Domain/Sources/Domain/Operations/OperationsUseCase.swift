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
    func aggregateOperations() -> AnyPublisher<[OperationsAggregator], CharlesError>
    func addOperation(title: String,
                      date: Date,
                      value: Double,
                      categoryId: String,
                      paymentMethodId: String,
                      installments: String) -> AnyPublisher<[Operation], CharlesError>
}

// MARK: Implementation
public final class OperationsUseCaseImpl {
    
    private let operationsRepository: OperationsRepository
    private let categoriesRepository: CategoriesRepository
    private let paymentMethodsRepository: PaymentMethodsRepository
    
    public init(operationsRepository: OperationsRepository,
                categoriesRepository: CategoriesRepository,
                paymentMethodsRepository: PaymentMethodsRepository) {
        self.operationsRepository = operationsRepository
        self.categoriesRepository = categoriesRepository
        self.paymentMethodsRepository = paymentMethodsRepository
    }
}

// MARK: Utils
extension OperationsUseCaseImpl {
    private func operations(month: Int?, year: Int?) -> AnyPublisher<[Operation], CharlesError> {
        let categories = categoriesRepository.categories()
        let paymentMethods = paymentMethodsRepository.paymentMethods()
        
        return categories
            .zip(paymentMethods)
            .flatMap { result -> AnyPublisher<[Operation], CharlesError> in
                return self.operationsRepository
                    .operations(month: month, year: year, categories: result.0, paymentMethods: result.1)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

// MARK: Interfaces
extension OperationsUseCaseImpl: OperationsUseCase {
    
    // MARK: Operations Aggregated
    public func aggregateOperations() -> AnyPublisher<[OperationsAggregator], CharlesError> {
        return operations(month: nil, year: nil)
            .map { operations in
                var aggregators: [OperationsAggregator] = []
                
                for operation in operations {
                    let components = Calendar.current.dateComponents([.month, .year], from: operation.date)
                    guard let month = components.month, let year = components.year else { continue }
                    
                    if let index = aggregators.firstIndex(where: { $0.month == month && $0.year == year }) {
                        aggregators[index].addOperation(operation)
                    } else {
                        let aggregator = OperationsAggregator(month: month, year: year, operations: [operation])
                        aggregators.append(aggregator)
                    }
                }
                
                return aggregators.sorted(by: { $0.dateToCompate > $1.dateToCompate })
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: Add
    public func addOperation(title: String,
                             date: Date,
                             value: Double,
                             categoryId: String,
                             paymentMethodId: String,
                             installments: String) -> AnyPublisher<[Operation], CharlesError> {
        let installments = installments.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let createOperation = CreateOperation(
            title: title,
            date: DateFormatter(pattern: "dd-MM-yyyy").string(from: date),
            value: value,
            categoryId: categoryId,
            paymentMethodId: paymentMethodId,
            installments: Int(installments)
        )
        
        let categories = categoriesRepository.categories()
        let paymentMethods = paymentMethodsRepository.paymentMethods()
        
        return categories
            .zip(paymentMethods)
            .flatMap { result -> AnyPublisher<[Operation], CharlesError> in
                return self.operationsRepository
                    .addOperation(createOperation: createOperation, categories: result.0, paymentMethods: result.1)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
