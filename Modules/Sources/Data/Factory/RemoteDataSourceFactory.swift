//
//  RemoteDataSourceFactory.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation

enum RemoteDataSourceFactory {
    
    static func operations() -> OperationsRemoteDataSource {
        return OperationsRemoteDataSourceImpl(session: .shared, queue: .main)
    }
}
