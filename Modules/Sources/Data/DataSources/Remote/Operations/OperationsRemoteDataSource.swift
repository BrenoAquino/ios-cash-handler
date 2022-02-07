//
//  RemoteDataSource.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine
import Domain

public protocol OperationsRemoteDataSource {
    func addOperation(params: CreateOperationParams) -> AnyPublisher<OperationDTO, CharlesError>
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
    public func addOperation(params: CreateOperationParams) -> AnyPublisher<OperationDTO, CharlesError> {
        return execute(endpoint: .addOperation(params: params))
    }
}
