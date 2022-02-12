//
//  PaymentMethodsRemoteDataSource.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Combine

public protocol PaymentMethodsRemoteDataSource {
    func paymentMethods() -> AnyPublisher<[PaymentMethodDTO], CharlesDataError>
}

// MARK: Implementation
public final class PaymentMethodsRemoteDataSourceImpl {
    typealias Endpoints = PaymentMethodsAPIs
    
    let networkProvider: NetworkProvider
    
    public init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
}

// MARK: Requests
extension PaymentMethodsRemoteDataSourceImpl: PaymentMethodsRemoteDataSource {
    public func paymentMethods() -> AnyPublisher<[PaymentMethodDTO], CharlesDataError> {
        return networkProvider.execute(endpoint: Endpoints.paymentMethod, keyPath: "data")
    }
}
