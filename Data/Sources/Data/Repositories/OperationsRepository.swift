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
    
    // MARK: Init
    public init(remoteDataSource: OperationsRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

// MARK: Interface
extension OperationsRepositoryImpl: Domain.OperationsRepository {
    public func operations(categories: [Domain.Category], paymentMethods: [Domain.PaymentMethod]) -> AnyPublisher<[Domain.Operation], CharlesError> {
        return remoteDataSource
            .operations()
            .tryMap { try $0.map { try $0.toDomain(paymentMethods: paymentMethods, categories: categories) } }
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
    
    public func addOperation(createOperation: CreateOperation,
                             categories: [Domain.Category],
                             paymentMethods: [Domain.PaymentMethod]) -> AnyPublisher<[Domain.Operation], CharlesError> {
        let params = CreateOperationParams(name: createOperation.name,
                                           date: createOperation.date,
                                           value: createOperation.value,
                                           categoryId: createOperation.categoryId,
                                           paymentMethodId: createOperation.paymentMethodId,
                                           installments: createOperation.installments)
        return remoteDataSource
            .addOperation(params: params)
            .tryMap { try $0.map { try $0.toDomain(paymentMethods: paymentMethods, categories: categories) } }
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
