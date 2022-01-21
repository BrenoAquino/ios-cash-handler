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
        let remoteDataSource = RemoteDataSourceFactory.operations()
        return OperationsRepositoryImpl(remoteDataSource: remoteDataSource)
    }
}
