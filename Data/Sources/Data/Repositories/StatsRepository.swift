//
//  StatsRepository.swift
//
//
//  Created by Breno Aquino on 28/04/22.
//

import Foundation
import Combine
import Domain
import Common

public final class StatsRepositoryImpl {
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Publishers
    private let statsPublisher: DataPublisher<Domain.Stats, CharlesError>
    private let historicPublisher: DataPublisher<[Domain.MonthStats], CharlesError>
    
    // MARK: DataSources
    private let statsRemoteDataSource: StatsRemoteDataSource
    
    // MARK: Init
    public init(statsRemoteDataSource: StatsRemoteDataSource) {
        self.statsRemoteDataSource = statsRemoteDataSource
        
        statsPublisher = .init(cacheRetrieveRule: .firstReloadIfNeeded, cacheTime: 60)
        historicPublisher = .init(cacheRetrieveRule: .firstReloadIfNeeded, cacheTime: 60)
    }
}

extension StatsRepositoryImpl: Domain.StatsRepository {
    public func historic(numberOfMonths: Int) -> AnyDataPubliher<[MonthStats], CharlesError> {
        defer {
            if historicPublisher.enableReload() {
                statsRemoteDataSource
                    .historic(numberOfMonths: numberOfMonths)
                    .map { $0.map { $0.toDomain() } }
                    .mapError { $0.toDomain() }
                    .sinkWithDataPublisher(historicPublisher)
                    .store(in: &cancellables)
            }
        }
        return historicPublisher.eraseToAnyPublisher()
    }
    
    public func stats(month: Int, year: Int, categories: [Domain.Category]) -> AnyDataPubliher<Stats, CharlesError> {
        defer {
            if statsPublisher.enableReload() {
                statsRemoteDataSource
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
                    .sinkWithDataPublisher(statsPublisher)
                    .store(in: &cancellables)
            }
        }
        return statsPublisher.eraseToAnyPublisher()
    }
}
