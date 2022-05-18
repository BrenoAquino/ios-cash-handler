//
//  OperationsRepository.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine
import Domain
import Common

public final class OperationsRepositoryImpl {
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Publisers
    private let operationsPublisher: DataPublisher<[Domain.Operation], CharlesError>
    private let addOperationPublisher: DataPublisher<[Domain.Operation], CharlesError>
    
    // MARK: DataSources
    private let remoteDataSource: OperationsRemoteDataSource
    
    // MARK: Init
    public init(remoteDataSource: OperationsRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
        
        operationsPublisher = .init(cacheRetrieveRule: .firstReloadIfNeeded, cacheTime: 60)
        addOperationPublisher = .init(cacheRetrieveRule: .firstReloadIfNeeded, cacheTime: 60)
    }
}

// MARK: Utils
extension OperationsRepositoryImpl {
    private func requestOperations(params: OperationsFilterParams?,
                                   categories: [Domain.Category],
                                   paymentMethods: [Domain.PaymentMethod]) -> AnyDataPubliher<[Domain.Operation], CharlesError>  {
        defer {
            if operationsPublisher.enableReload() {
                operationsPublisher.loading()
                remoteDataSource
                    .operations(params: params)
                    .tryMap { try $0.map { try $0.toDomain(paymentMethods: paymentMethods, categories: categories) } }
                    .mapError { error in
                        switch error {
                        case let error as CharlesDataError:
                            return error.toDomain()
                        default:
                            return CharlesError(type: .unkown)
                        }
                    }
                    .sinkWithDataPublisher(operationsPublisher)
                    .store(in: &cancellables)
            }
        }
        return operationsPublisher.eraseToAnyPublisher()
    }
}

// MARK: Interface
extension OperationsRepositoryImpl: Domain.OperationsRepository {
    public func operations(month: Int?,
                           year: Int?,
                           categories: [Domain.Category],
                           paymentMethods: [Domain.PaymentMethod]) -> AnyDataPubliher<[Domain.Operation], CharlesError> {
        var params: OperationsFilterParams? = nil
        if let month = month, let year = year { params = .init(month: month, year: year) }
        return requestOperations(params: params, categories: categories, paymentMethods: paymentMethods)
    }
    
    public func operations(startMonth: Int,
                           startYear: Int,
                           endMonth: Int,
                           endYear: Int,
                           categories: [Domain.Category],
                           paymentMethods: [Domain.PaymentMethod]) -> AnyDataPubliher<[Domain.Operation], CharlesError> {
        let params: OperationsFilterParams = .init(startMonth: startMonth, startYear: startYear, endMonth: endMonth, endYear: endYear)
        return requestOperations(params: params, categories: categories, paymentMethods: paymentMethods)
    }
    
    public func addOperation(createOperation: Domain.CreateOperation,
                             categories: [Domain.Category],
                             paymentMethods: [Domain.PaymentMethod]) -> AnyDataPubliher<[Domain.Operation], CharlesError> {
        defer {
            if addOperationPublisher.enableReload() {
                let params = CreateOperationParams(title: createOperation.title,
                                                   date: createOperation.date,
                                                   value: createOperation.value,
                                                   categoryId: createOperation.categoryId,
                                                   paymentMethodId: createOperation.paymentMethodId,
                                                   installments: createOperation.installments)
                remoteDataSource
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
                    .sinkWithDataPublisher(addOperationPublisher)
                    .store(in: &cancellables)
            }
        }   
        return addOperationPublisher.eraseToAnyPublisher()
    }
}
