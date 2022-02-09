//
//  CategoriesRepository.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Combine
import Domain

public final class CategoriesRepositoryImpl {
    private let remoteDataSource: CategoriesRemoteDataSource
    
    public init(remoteDataSource: CategoriesRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

// MARK: Interface
extension CategoriesRepositoryImpl: Domain.CategoriesRepository {
    public func fetchCategories() -> AnyPublisher<[Domain.Category], CharlesError> {
        return remoteDataSource
            .categories()
            .map { $0.map { $0.toDomain() } }
            .mapError { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
