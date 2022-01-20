//
//  RemoteDataSource.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Combine
import Domain

protocol OperationsRemoteDataSource {
    func addOperation(params: CreateOperationParams) -> AnyPublisher<OperationDTO, Error>
}

// MARK: Implementation
final class OperationsRemoteDataSourceImpl: Network {
    typealias Endpoints = OperationsAPIs
    
    var session: URLSession
    var queue: DispatchQueue
    
    init(session: URLSession, queue: DispatchQueue) {
        self.session = session
        self.queue = queue
    }
}

// MARK: Requests
extension OperationsRemoteDataSourceImpl: OperationsRemoteDataSource {
    func addOperation(params: CreateOperationParams) -> AnyPublisher<OperationDTO, Error> {
        return execute(endpoint: .addOperation(params: params))
    }
}
