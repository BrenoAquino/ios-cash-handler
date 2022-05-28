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
    public func paymentMethods() -> AnyPublisher<[PaymentMethod], CharlesError> {
        let paymentMethods = localDataSource.paymentMethods()
        if !paymentMethods.isEmpty {
            let domain = paymentMethods.map { $0.toDomain() }
            return Just(domain)
                .setFailureType(to: CharlesError.self)
                .eraseToAnyPublisher()
        }
        
        return remoteDataSource
            .paymentMethods()
            .handleEvents(receiveOutput: { [weak self] value in
                let entities = value.map { $0.toEntity() }
                self?.localDataSource.updatePaymentMethods(entities)
            })
            .map { $0.map { $0.toDomain() } }
            .mapError { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
