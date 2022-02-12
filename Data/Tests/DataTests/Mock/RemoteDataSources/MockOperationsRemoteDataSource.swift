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
    
    func addOperation(params: CreateOperationParams) -> AnyPublisher<OperationDTO, CharlesDataError> {
        let operation: OperationDTO = .init(
            id: "123",
            title: params.title,
            date: params.date,
            categoryId: params.categoryId,
            paymentMethodId: params.paymentMethodId,
            value: params.value
        )
        return Just(operation)
            .mapError { _ in return CharlesDataError(type: .unkown) }
            .eraseToAnyPublisher()
    }
}

class MockErrorOperationsRemoteDataSource: OperationsRemoteDataSource {
    
    func addOperation(params: CreateOperationParams) -> AnyPublisher<OperationDTO, CharlesDataError> {
        let error = CharlesDataError(type: .badRequest)
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
}
