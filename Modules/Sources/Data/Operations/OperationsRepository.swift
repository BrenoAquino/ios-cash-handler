//
//  OperationsRepository.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine
import Domain

protocol OperationsRepository {
    func addOperation(params: CreateOperationParams) -> AnyPublisher<Domain.Operation, Error>
}

// MARK: Implementation
final class OperationsRepositoryImpl {
    private let remoteDataSource: OperationsRemoteDataSource
    
    init(remoteDataSource: OperationsRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

// MARK: Interface
extension OperationsRepositoryImpl: OperationsRepository {
    func addOperation(params: CreateOperationParams) -> AnyPublisher<Domain.Operation, Error> {
        return remoteDataSource
            .addOperation(params: params)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
