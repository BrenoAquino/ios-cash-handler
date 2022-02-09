//
//  PaymentMethodsRemoteDataSource.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Combine

public protocol PaymentMethodsRemoteDataSource {
    func paymentMethods() -> AnyPublisher<[PaymentMethod], CharlesDataError>
}

// MARK: Implementation
public final class PaymentMethodsRemoteDataSourceImpl: Network {
    typealias Endpoints = PaymentMethodsAPIs
    
    var session: URLSession
    var queue: DispatchQueue
    
    public init(session: URLSession, queue: DispatchQueue) {
        self.session = session
        self.queue = queue
    }
}

// MARK: Requests
extension PaymentMethodsRemoteDataSourceImpl: PaymentMethodsRemoteDataSource {
    public func paymentMethods() -> AnyPublisher<[PaymentMethod], CharlesDataError> {
        return execute(endpoint: .paymentMethod, keyPath: "data")
    }
}
