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
    
    // MARK: DataSources
    private let remoteDataSource: OperationsRemoteDataSource
    private let paymentMethodsLocalDataSource: PaymentMethodsLocalDataSource
    private let categoriesLocalDataSource: CategoriesLocalDataSource
    
    // MARK: Gets
    private var categories: [Domain.Category] {
        categoriesLocalDataSource.categories().map { $0.toDomain() }
    }
    
    private var  paymentMethods: [Domain.PaymentMethod] {
        paymentMethodsLocalDataSource.paymentMethods().map { $0.toDomain() }
    }
    
    // MARK: Init
    public init(remoteDataSource: OperationsRemoteDataSource,
                paymentMethodsLocalDataSource: PaymentMethodsLocalDataSource,
                categoriesLocalDataSource: CategoriesLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.paymentMethodsLocalDataSource = paymentMethodsLocalDataSource
        self.categoriesLocalDataSource = categoriesLocalDataSource
    }
}

// MARK: Utils
extension OperationsRepositoryImpl {
    private func requestOperations(params: OperationsFilterParams?) -> AnyPublisher<[Domain.Operation], CharlesError>  {
        return remoteDataSource
            .operations(params: params)
            .tryMap { [weak self] operationsDTOs in
                if let categories = self?.categories, let paymentMethods = self?.paymentMethods {
                    do {
                        return try operationsDTOs.map { try $0.toDomain(paymentMethods: paymentMethods, categories: categories) }
                    } catch {
                        throw CharlesDataError(type: .invalidDomainConverter)
                    }
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

// MARK: Interface
extension OperationsRepositoryImpl: Domain.OperationsRepository {
    public func operations(month: Int?, year: Int?) -> AnyPublisher<[Domain.Operation], CharlesError> {
        var params: OperationsFilterParams? = nil
        if let month = month, let year = year {
            params = .init(month: month, year: year)
        }
        return requestOperations(params: params)
    }
    
    public func operations(startMonth: Int, startYear: Int, endMonth: Int, endYear: Int) -> AnyPublisher<[Domain.Operation], CharlesError> {
        let params: OperationsFilterParams = .init(startMonth: startMonth, startYear: startYear, endMonth: endMonth, endYear: endYear)
        return requestOperations(params: params)
    }
    
    public func addOperation(createOperation: CreateOperation) -> AnyPublisher<[Domain.Operation], CharlesError> {
        let params = CreateOperationParams(name: createOperation.name,
                                           date: createOperation.date,
                                           value: createOperation.value,
                                           categoryId: createOperation.categoryId,
                                           paymentMethodId: createOperation.paymentMethodId,
                                           installments: createOperation.installments)
        return remoteDataSource
            .addOperation(params: params)
            .tryMap { [weak self] operations in
                if let categories = self?.categories,
                   let paymentMethods = self?.paymentMethods {
                    do {
                        return try operations.map { try $0.toDomain(paymentMethods: paymentMethods, categories: categories) }
                    } catch {
                        throw CharlesDataError(type: .invalidDomainConverter)
                    }
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
