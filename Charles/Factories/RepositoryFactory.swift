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
    
    static func operations() -> OperationsRepository {
        return OperationsRepositoryImpl(remoteDataSource: RemoteDataSourceFactory.operations(),
                                        paymentMethodsLocalDataSource: LocalDataSourceFactory.paymentMethods(),
                                        categoriesLocalDataSource: LocalDataSourceFactory.categories())
    }
    
    static func categories() -> CategoriesRepository {
        let remoteDataSource = RemoteDataSourceFactory.categories()
        return CategoriesRepositoryImpl(remoteDataSource: remoteDataSource)
    }
    
    static func paymentMethods() -> PaymentMethodsRepository {
        let remoteDataSource = RemoteDataSourceFactory.paymentMethods()
        return PaymentMethodsRepositoryImpl(remoteDataSource: remoteDataSource)
    }
}
