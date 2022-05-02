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

public final class _CategoriesRepositoryImpl {
    
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
extension _CategoriesRepositoryImpl: Domain._CategoriesRepository {
    public func categories() -> AnyPublisher<[Domain.Category], CharlesError> {
        defer {
            if categoriesPublishers.enableReload() {
                remoteDataSource
                    .categories()
                    .map { $0.map { $0.toDomain() } }
                    .mapError { $0.toDomain() }
                    .sink { [weak self] completion in
                        self?.categoriesPublishers.finish(completion)
                    } receiveValue: { [weak self] categories in
                        self?.categoriesPublishers.loaded(categories)
                    }
                    .store(in: &cancellables)
            }
        }
        return categoriesPublishers.eraseToAnyPublisher()
    }
}
