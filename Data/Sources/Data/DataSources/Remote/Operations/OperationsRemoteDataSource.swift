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
public final class OperationsRemoteDataSourceImpl: Network {
    typealias Endpoints = OperationsAPIs
    
    var session: URLSession
    var queue: DispatchQueue
    
    public init(session: URLSession, queue: DispatchQueue) {
        self.session = session
        self.queue = queue
    }
}

// MARK: Requests
extension OperationsRemoteDataSourceImpl: OperationsRemoteDataSource {
    public func addOperation(params: CreateOperationParams) -> AnyPublisher<OperationDTO, CharlesDataError> {
        return execute(endpoint: .addOperation(params: params))
    }
}
