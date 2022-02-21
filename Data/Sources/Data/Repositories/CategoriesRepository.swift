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
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: DataSources
    private let remoteDataSource: CategoriesRemoteDataSource
    private let localDataSource: CategoriesLocalDataSource
    
    // MARK: Init
    public init(remoteDataSource: CategoriesRemoteDataSource,
                localDataSource: CategoriesLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
}

// MARK: Interface
extension CategoriesRepositoryImpl: Domain.CategoriesRepository {
    public func cachedCategories() -> [Domain.Category] {
        localDataSource.categories().map { $0.toDomain() }
    }
    
    public func fetchCategories() -> AnyPublisher<[Domain.Category], CharlesError> {
        return remoteDataSource
            .categories()
            .handleEvents(receiveOutput: { [weak self] value in
                let categoriesEntity = value.map { $0.toEntity() }
                self?.localDataSource.updateCategories(categoriesEntity)
            })
            .map { $0.map { $0.toDomain() } }
            .mapError { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
