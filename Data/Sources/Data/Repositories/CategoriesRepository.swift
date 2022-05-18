//
//  CategoriesRepository.swift
//  
//
//  Created by Breno Aquino on 02/05/22.
//

import Foundation
import Combine
import Domain
import Common

public final class CategoriesRepositoryImpl {
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: Publishers
    private let categoriesPublishers: DataPublisher<[Domain.Category], CharlesError>
    
    // MARK: DataSources
    private let remoteDataSource: CategoriesRemoteDataSource
    
    // MARK: Init
    public init(remoteDataSource: CategoriesRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
        
        categoriesPublishers = .init(cacheRetrieveRule: .firstReloadIfNeeded, cacheTime: 60)
    }
}

// MARK: Interface
extension CategoriesRepositoryImpl: Domain.CategoriesRepository {
    public func categories() -> AnyDataPubliher<[Domain.Category], CharlesError> {
        defer {
            if categoriesPublishers.enableReload() {
                remoteDataSource
                    .categories()
                    .map { $0.map { $0.toDomain() } }
                    .mapError { $0.toDomain() }
                    .sinkWithDataPublisher(categoriesPublishers)
                    .store(in: &cancellables)
            }
        }
        return categoriesPublishers.eraseToAnyPublisher()
    }
}
