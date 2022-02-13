//
//  OperationsRepository.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine
import Domain

public final class OperationsRepositoryImpl {
    
    private let categories: [Domain.Category]
    private let paymentMethods: [Domain.PaymentMethod]
    
    // MARK: DataSources
    private let remoteDataSource: OperationsRemoteDataSource
    private let paymentMethodsLocalDataSource: PaymentMethodsLocalDataSource
    private let categoriesLocalDataSource: CategoriesLocalDataSource
    
    // MARK: Init
    public init(remoteDataSource: OperationsRemoteDataSource,
                paymentMethodsLocalDataSource: PaymentMethodsLocalDataSource,
                categoriesLocalDataSource: CategoriesLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.paymentMethodsLocalDataSource = paymentMethodsLocalDataSource
        self.categoriesLocalDataSource = categoriesLocalDataSource
        
        categories = categoriesLocalDataSource.categories().map { $0.toDomain() }
        paymentMethods = paymentMethodsLocalDataSource.paymentMethods().map { $0.toDomain() }
    }
}

// MARK: Interface
extension OperationsRepositoryImpl: Domain.OperationsRepository {
    public func addOperation(title: String,
                      date: String,
                      value: Double,
                      categoryId: Int,
                      paymentTypeId: Int) -> AnyPublisher<Domain.Operation, CharlesError> {
        let params = CreateOperationParams(title: title, date: date, value: value, categoryId: categoryId, paymentMethodId: paymentTypeId)
        return remoteDataSource
            .addOperation(params: params)
            .tryMap { [weak self] operation in
                if let categories = self?.categories,
                   let paymentMethods = self?.paymentMethods,
                   let operationDomain = operation.toDomain(paymentMethods: paymentMethods, categories: categories) {
                    return operationDomain
                } else {
                    throw CharlesDataError(type: .invalidDomainConverter)
                }
            }
            .mapError { error in
                switch error {
                case let error as CharlesDataError:
                    return error.toDomain()
                default:
                    return CharlesError(type: .unkown)
                }
            }
            .eraseToAnyPublisher()
    }
}
