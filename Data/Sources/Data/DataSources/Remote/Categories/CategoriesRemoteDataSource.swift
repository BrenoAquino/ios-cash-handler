//
//  CategoriesRemoteDataSource.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Combine

public protocol CategoriesRemoteDataSource {
    func categories() -> AnyPublisher<[CategoryDTO], CharlesDataError>
}

public final class CategoriesRemoteDataSourceImpl {
    typealias Endpoints = CategoriesAPIs
    
    let networkProvider: NetworkProvider
    
    public init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
}

// MARK: Requests
extension CategoriesRemoteDataSourceImpl: CategoriesRemoteDataSource {
    public func categories() -> AnyPublisher<[CategoryDTO], CharlesDataError> {
        return networkProvider.execute(endpoint: Endpoints.categories, keyPath: "data")
    }
}
