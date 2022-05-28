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
    
    // MARK: Init
    public init(statsRemoteDataSource: StatsRemoteDataSource) {
        self.statsRemoteDataSource = statsRemoteDataSource
    }
}

extension StatsRepositoryImpl: Domain.StatsRepository {
    public func historic(startDate: String, endDate: String) -> AnyPublisher<[MonthStats], CharlesError> {
        let params = HistoricParams(startDate: startDate, endDate: endDate)
        return statsRemoteDataSource
            .historic(params: params)
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
    
    public func stats(month: Int, year: Int, categories: [Domain.Category]) -> AnyPublisher<Stats, CharlesError> {
        return statsRemoteDataSource
            .stats(params: .init(month: month, year: year))
            .tryMap { try $0.toDomain(categories: categories) }
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
