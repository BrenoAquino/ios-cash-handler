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
    private let remoteDataSource: OperationsRemoteDataSource
    
    public init(remoteDataSource: OperationsRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

// MARK: Interface
extension OperationsRepositoryImpl: Domain.OperationsRepository {
    public func addOperation(title: String,
                      date: String,
                      value: Double,
                      category: String,
                      paymentType: String,
                      operationType: String) -> AnyPublisher<Domain.Operation, Error> {
        let params = CreateOperationParams(title: title,
                                           date: date,
                                           value: value,
                                           category: category,
                                           paymentType: paymentType,
                                           operationType: operationType)
        return remoteDataSource
            .addOperation(params: params)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
