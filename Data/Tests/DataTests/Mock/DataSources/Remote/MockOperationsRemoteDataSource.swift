//
//  MockOperationsRemoteDataSource.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

import Foundation
import Combine

@testable import Data

class MockSuccessOperationsRemoteDataSource: OperationsRemoteDataSource {
    func operations() -> AnyPublisher<[OperationDTO], CharlesDataError> {
        let operation: OperationDTO = .init(
            id: "123",
            name: "title",
            date: "2022-01-01",
            categoryId: "0",
            paymentMethodId: "0",
            value: 123,
            currentInstallments: nil,
            totalInstallments: nil,
            operationAggregatorId: nil
        )
        return Just([operation])
            .setFailureType(to: CharlesDataError.self)
            .eraseToAnyPublisher()
    }
    
    
    func addOperation(params: CreateOperationParams) -> AnyPublisher<[OperationDTO], CharlesDataError> {
        let operation: [OperationDTO] = [
            .init(
                id: "123",
                name: params.name,
                date: params.date,
                categoryId: params.categoryId,
                paymentMethodId: params.paymentMethodId,
                value: params.value,
                currentInstallments: nil,
                totalInstallments: nil,
                operationAggregatorId: nil
            )
        ]
        return Just(operation)
            .setFailureType(to: CharlesDataError.self)
            .eraseToAnyPublisher()
    }
}

class MockErrorOperationsRemoteDataSource: OperationsRemoteDataSource {
    func operations() -> AnyPublisher<[OperationDTO], CharlesDataError> {
        let error = CharlesDataError(type: .badRequest)
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
    
    func addOperation(params: CreateOperationParams) -> AnyPublisher<[OperationDTO], CharlesDataError> {
        let error = CharlesDataError(type: .badRequest)
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
}
