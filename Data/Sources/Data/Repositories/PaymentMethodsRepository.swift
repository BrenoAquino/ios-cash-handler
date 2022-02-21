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
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: DataSources
    private let remoteDataSource: PaymentMethodsRemoteDataSource
    private let localDataSource: PaymentMethodsLocalDataSource
    
    // MARK: Init
    public init(remoteDataSource: PaymentMethodsRemoteDataSource,
                localDataSource: PaymentMethodsLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
}

extension PaymentMethodsRepositoryImpl: Domain.PaymentMethodsRepository {
    public func cachedPaymentMethods() -> [Domain.PaymentMethod] {
        localDataSource.paymentMethods().map { $0.toDomain() }
    }
    
    public func fetchPaymentMethods() -> AnyPublisher<[Domain.PaymentMethod], CharlesError> {
        return remoteDataSource
            .paymentMethods()
            .handleEvents(receiveOutput: { [weak self] value in
                let paymentMethodsEntity = value.map { $0.toEntity() }
                self?.localDataSource.updatePaumentMethods(paymentMethodsEntity)
            })
            .map { $0.map { $0.toDomain() } }
            .mapError { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
