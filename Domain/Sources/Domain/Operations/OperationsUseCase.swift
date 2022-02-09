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
    func categories() -> AnyPublisher<[Category], CharlesError>
    func paymentMethods() -> AnyPublisher<[PaymentMethod], CharlesError>
    func addOperation(title: String, date: Date, value: String, category: String, paymentType: String) -> AnyPublisher<Operation, CharlesError>
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
    
    public func categories() -> AnyPublisher<[Category], CharlesError> {
        return categoriesRepository
            .fetchCategories()
    }
    
    public func paymentMethods() -> AnyPublisher<[PaymentMethod], CharlesError> {
        return paymentMethodsRepository
            .fetchPaymentMethods()
    }
    
    public func addOperation(title: String, date: Date, value: String, category: String, paymentType: String) -> AnyPublisher<Operation, CharlesError> {
        guard let value = Double(value) else {
            return Fail(error: CharlesError(type: .wrongInputType))
                .eraseToAnyPublisher()
        }
        
        let dateString = DateFormatter(pattern: "dd-MM-yyyy").string(from: date)
        return operationsRepository
            .addOperation(title: title, date: dateString, value: value, categoryId: 0, paymentTypeId: 0)
    }
}
