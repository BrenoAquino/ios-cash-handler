//
//  PaymentMethodsRepository.swift
//  
//
//  Created by Breno Aquino on 02/05/22.
//

import Foundation
import Combine
import Domain
import Common

public final class PaymentMethodsRepositoryImpl {
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: Publishers
    private let paymentMethodsPublisher: DataPublisher<[Domain.PaymentMethod], CharlesError>
    
    // MARK: DataSources
    private let remoteDataSource: PaymentMethodsRemoteDataSource
    
    // MARK: Init
    public init(remoteDataSource: PaymentMethodsRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
        
        paymentMethodsPublisher = .init(cacheRetrieveRule: .firstReloadIfNeeded, cacheTime: 60)
    }
}

// MARK: Interface
extension PaymentMethodsRepositoryImpl: Domain.PaymentMethodsRepository {
    public func paymentMethods() -> AnyDataPubliher<[Domain.PaymentMethod], CharlesError> {
        defer {
            if paymentMethodsPublisher.enableReload() {
                remoteDataSource
                    .paymentMethods()
                    .map { $0.map { $0.toDomain() } }
                    .mapError { $0.toDomain() }
                    .sinkWithDataPublisher(paymentMethodsPublisher)
                    .store(in: &cancellables)
            }
        }
        return paymentMethodsPublisher.eraseToAnyPublisher()
    }
}
