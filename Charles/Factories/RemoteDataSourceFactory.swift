//
//  RemoteDataSourceFactory.swift
//  Charles
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Data

enum RemoteDataSourceFactory {
    
    static func operations() -> OperationsRemoteDataSource {
        return OperationsRemoteDataSourceImpl(session: .shared, queue: .main)
    }
    
    static func categories() -> CategoriesRemoteDataSource {
        return CategoriesRemoteDataSourceImpl(session: .shared, queue: .main)
    }
}
