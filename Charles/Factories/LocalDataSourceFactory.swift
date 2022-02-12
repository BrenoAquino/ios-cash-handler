//
//  LocalDataSourceFactory.swift
//  Charles
//
//  Created by Breno Aquino on 12/02/22.
//

import Foundation
import Data

enum LocalDataSourceFactory {
    
    private static func database() -> Database {
        return UserDefaultsDB.shared
    }
    
    static func categories() -> CategoriesLocalDataSource {
        return CategoriesLocalDataSourceImpl(database: database())
    }
    
    static func paymentMethods() -> PaymentMethodsLocalDataSource {
        return PaymentMethodsLocalDataSourceImpl(database: database())
    }
}
