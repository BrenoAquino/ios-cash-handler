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
    func addOperation(name: String,
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

// MARK: Interfaces
extension OperationsUseCaseImpl: OperationsUseCase {
    
    // MARK: Operations Aggregated
    public func aggregateOperations() -> AnyPublisher<[OperationsAggregator], CharlesError> {
        typealias OperationsMap = ([Category], [PaymentMethod]) -> AnyPublisher<[Operation], CharlesError>
        let handleOperations: OperationsMap = { [weak self] (categories, paymentMethods) in
            guard let self = self else {
                return Fail(error: CharlesError(type: .unkown)).eraseToAnyPublisher()
            }
            
            return self.operationsRepository
                .operations(categories: categories, paymentMethods: paymentMethods)
                .eraseToAnyPublisher()
        }
        
        let categoriesPublisher = categoriesRepository.categories()
        let paymentMethodsPublisher = paymentMethodsRepository.paymentMethods()
        return Publishers.Zip(categoriesPublisher, paymentMethodsPublisher)
            .map(handleOperations)
            .switchToLatest()
            .map { $0.sorted(by: { $0.name < $1.name }) }
            .map { $0.sorted(by: { $0.date > $1.date }) }
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
    public func addOperation(name: String,
                             date: Date,
                             value: Double,
                             categoryId: String,
                             paymentMethodId: String,
                             installments: String) -> AnyPublisher<[Operation], CharlesError> {
        let installments = installments.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let createOperation = CreateOperation(name: name,
                                              date: DateFormatter(pattern: "yyyy-MM-dd").string(from: date),
                                              value: value,
                                              categoryId: categoryId,
                                              paymentMethodId: paymentMethodId,
                                              installments: Int(installments))
        
        typealias AddOperationMap = ([Category], [PaymentMethod]) -> AnyPublisher<[Operation], CharlesError>
        let handleAddOperation: AddOperationMap = { [weak self] (categories, paymentMethods) in
            guard let self = self else {
                return Fail(error: CharlesError(type: .unkown)).eraseToAnyPublisher()
            }
            
            return self.operationsRepository
                .addOperation(createOperation: createOperation, categories: categories, paymentMethods: paymentMethods)
                .eraseToAnyPublisher()
        }
        
        let categoriesPublisher = categoriesRepository.categories()
        let paymentMethodsPublisher = paymentMethodsRepository.paymentMethods()
        return Publishers.Zip(categoriesPublisher, paymentMethodsPublisher)
            .map(handleAddOperation)
            .switchToLatest()
            .eraseToAnyPublisher()
    }
}
