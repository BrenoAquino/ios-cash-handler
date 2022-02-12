//
//  PaymentMethodsRepository.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Combine
import Domain

public final class PaymentMethodsRepositoryImpl {
    
    // MARK: DataSources
    private let remoteDataSource: PaymentMethodsRemoteDataSource
    
    // MARK: Init
    public init(remoteDataSource: PaymentMethodsRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

extension PaymentMethodsRepositoryImpl: Domain.PaymentMethodsRepository {
    public func fetchPaymentMethods() -> AnyPublisher<[PaymentMethod], CharlesError> {
        return remoteDataSource
            .paymentMethods()
            .map { $0.map { $0.toDomain() } }
            .mapError { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
