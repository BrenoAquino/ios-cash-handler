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
    func categories() -> [Category]
    func paymentMethods() -> [PaymentMethod]
    func operations() -> AnyPublisher<[OperationsAggregator], CharlesError>
    func addOperation(title: String, date: Date, value: Double, categoryId: String, paymentMethodId: String) -> AnyPublisher<[Operation], CharlesError>
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
    
    public func categories() -> [Category] {
        return categoriesRepository
            .cachedCategories()
    }
    
    public func paymentMethods() -> [PaymentMethod] {
        return paymentMethodsRepository
            .cachedPaymentMethods()
    }
    
    public func operations() -> AnyPublisher<[OperationsAggregator], CharlesError> {
        return operationsRepository
            .operations()
            .map { $0.sorted(by: { $0.title < $1.title }) }
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
    
    public func addOperation(title: String,
                             date: Date,
                             value: Double,
                             categoryId: String,
                             paymentMethodId: String) -> AnyPublisher<[Operation], CharlesError> {
        let dateString = DateFormatter(pattern: "dd-MM-yyyy").string(from: date)
        return operationsRepository
            .addOperation(title: title, date: dateString, value: value, categoryId: categoryId, paymentMethodId: paymentMethodId)
    }
}
