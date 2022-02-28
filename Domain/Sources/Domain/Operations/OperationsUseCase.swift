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
    func operations() -> AnyPublisher<[Operation], CharlesError>
    func addOperation(title: String, date: Date, value: Double, categoryId: String, paymentMethodId: String) -> AnyPublisher<Operation, CharlesError>
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
    
    public func operations() -> AnyPublisher<[Operation], CharlesError> {
        return operationsRepository
            .operations()
    }
    
    public func addOperation(title: String,
                             date: Date,
                             value: Double,
                             categoryId: String,
                             paymentMethodId: String) -> AnyPublisher<Operation, CharlesError> {
        let dateString = DateFormatter(pattern: "dd-MM-yyyy").string(from: date)
        return operationsRepository
            .addOperation(title: title, date: dateString, value: value, categoryId: categoryId, paymentMethodId: paymentMethodId)
    }
}
