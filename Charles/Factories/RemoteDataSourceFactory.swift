//
//  RemoteDataSourceFactory.swift
//  Charles
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Data

enum RemoteDataSourceFactory {
    
    private static func networkProvider() -> NetworkProvider {
        return URLSessionNetwork(session: .shared)
    }
    
    private static let operationsRemoteDataSource = OperationsRemoteDataSourceImpl(networkProvider: Self.networkProvider())
    static func operations() -> OperationsRemoteDataSource {
        return operationsRemoteDataSource
    }
    
    private static let categoriesRemoteDataSource = CategoriesRemoteDataSourceImpl(networkProvider: Self.networkProvider())
    static func categories() -> CategoriesRemoteDataSource {
        return categoriesRemoteDataSource
    }
    
    private static let paymentMethodsRemoteDataSource = PaymentMethodsRemoteDataSourceImpl(networkProvider: Self.networkProvider())
    static func paymentMethods() -> PaymentMethodsRemoteDataSource {
        return paymentMethodsRemoteDataSource
    }
    
    private static let statsRemoteDataSource = StatsRemoteDataSourceImpl(networkProvider: Self.networkProvider())
    static func stats() -> StatsRemoteDataSource {
        return statsRemoteDataSource
    }
}
