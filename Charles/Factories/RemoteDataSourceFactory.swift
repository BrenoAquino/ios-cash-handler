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
    
    static func operations() -> OperationsRemoteDataSource {
        return OperationsRemoteDataSourceImpl(networkProvider: Self.networkProvider())
    }
    
    static func categories() -> CategoriesRemoteDataSource {
        return CategoriesRemoteDataSourceImpl(networkProvider: Self.networkProvider())
    }
    
    static func paymentMethods() -> PaymentMethodsRemoteDataSource {
        return PaymentMethodsRemoteDataSourceImpl(networkProvider: Self.networkProvider())
    }
    
    static func stats() -> StatsRemoteDataSource {
        return StatsRemoteDataSourceImpl(networkProvider: Self.networkProvider())
    }
}
