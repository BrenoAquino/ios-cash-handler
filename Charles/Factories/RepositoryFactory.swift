//
//  RepositoryFactory.swift
//  Charles
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Domain
import Data

enum RepositoryFactory {
    
    private static let operationsRepository = OperationsRepositoryImpl(remoteDataSource: RemoteDataSourceFactory.operations())
    static func operations() -> OperationsRepository {
        return operationsRepository
    }
    
    private static let categoriesRepository = CategoriesRepositoryImpl(remoteDataSource: RemoteDataSourceFactory.categories())
    static func categories() -> CategoriesRepository {
        return categoriesRepository
    }
    
    private static let paymentMethodsRepository = PaymentMethodsRepositoryImpl(remoteDataSource: RemoteDataSourceFactory.paymentMethods())
    static func paymentMethods() -> PaymentMethodsRepository {
        return paymentMethodsRepository
    }
    
    private static let statsRepository = StatsRepositoryImpl(statsRemoteDataSource: RemoteDataSourceFactory.stats())
    static func stats() -> StatsRepository {
        return statsRepository
    }
}
