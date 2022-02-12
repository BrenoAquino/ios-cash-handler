//
//  RemoteDataSource.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine

public protocol OperationsRemoteDataSource {
    func addOperation(params: CreateOperationParams) -> AnyPublisher<OperationDTO, CharlesDataError>
}

// MARK: Implementation
public final class OperationsRemoteDataSourceImpl {
    typealias Endpoint = OperationsAPIs
    
    let networkProvider: NetworkProvider
    
    public init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
}

// MARK: Requests
extension OperationsRemoteDataSourceImpl: OperationsRemoteDataSource {
    public func addOperation(params: CreateOperationParams) -> AnyPublisher<OperationDTO, CharlesDataError> {
        return networkProvider.execute(endpoint: Endpoint.addOperation(params: params), keyPath: "data")
    }
}
