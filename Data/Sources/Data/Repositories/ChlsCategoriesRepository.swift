//
//  ChlsCategoriesRepository.swift
//  
//
//  Created by Breno Aquino on 01/05/22.
//

import Foundation
import Combine
import Domain

public final class ChlsCategoriesRepository {
    
    // MARK: Propierties
    private var cancellables: Set<AnyCancellable> = []
    private var categoriesPublisher: DataPublisher<[Domain.Category], CharlesDataError>
    
    // MARK: DataSources
    private let remoteDataSource: CategoriesRemoteDataSource
    
    // MARK: Init
    public init(remoteDataSource: CategoriesRemoteDataSource, cacheTime: TimeInterval) {
        self.remoteDataSource = remoteDataSource
        self.categoriesPublisher = .init(cacheTime: cacheTime)
    }
}

// MARK: Second Try
extension ChlsCategoriesRepository {
    func fetchCategories() -> AnyPublisher<[Domain.Category], CharlesDataError> {
        defer {
            if categoriesPublisher.enableReload() {
                self.categoriesPublisher.loading()
                remoteDataSource
                    .categories()
                    .map { $0.map { $0.toDomain() } }
                    .mapError { $0.toDomain() }
                    .sinkReceiveValue { categoriesModel in
                        self.categoriesPublisher.loaded(categoriesModel)
                    }
                    .store(in: &cancellables)
            }
        }
        return categoriesPublisher.eraseToAnyPublisher()
    }
}
