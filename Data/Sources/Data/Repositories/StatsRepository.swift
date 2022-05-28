//
//  StatsRepository.swift
//  
//
//  Created by Breno Aquino on 28/04/22.
//

import Foundation
import Combine
import Domain

public final class StatsRepositoryImpl {
    
    // MARK: DataSources
    private let statsRemoteDataSource: StatsRemoteDataSource
    private let categoriesLocalDataSource: CategoriesLocalDataSource
    
    // MARK: Gets
    private var categories: [Domain.Category] {
        categoriesLocalDataSource.categories().map { $0.toDomain() }
    }
    
    // MARK: Init
    public init(statsRemoteDataSource: StatsRemoteDataSource,
                categoriesLocalDataSource: CategoriesLocalDataSource) {
        self.statsRemoteDataSource = statsRemoteDataSource
        self.categoriesLocalDataSource = categoriesLocalDataSource
    }
}

extension StatsRepositoryImpl: Domain.StatsRepository {
    public func historic(numberOfMonths: Int) -> AnyPublisher<[MonthStats], CharlesError> {
        return statsRemoteDataSource
            .historic(numberOfMonths: numberOfMonths)
            .tryMap { try $0.map { try $0.toDomain() } }
            .mapError { error in
                switch error {
                case let error as CharlesDataError:
                    return error.toDomain()
                default:
                    return CharlesError(type: .unkown)
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func stats(month: Int, year: Int) -> AnyPublisher<Stats, CharlesError> {
        return statsRemoteDataSource
            .stats(params: .init(month: month, year: year))
            .tryMap { [weak self] stats in
                guard let categories = self?.categories else { throw CharlesDataError(type: .invalidDomainConverter) }
                return try stats.toDomain(categories: categories)
            }
            .mapError { error in
                switch error {
                case let error as CharlesDataError:
                    return error.toDomain()
                default:
                    return CharlesError(type: .unkown)
                }
            }
            .eraseToAnyPublisher()
    }
}
