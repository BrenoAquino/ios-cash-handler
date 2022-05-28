//
//  MockStatsRemoteDataSource.swift
//  
//
//  Created by Breno Aquino on 28/04/22.
//

import Foundation
import Combine

@testable import Data

class MockSuccessStatsRemoteDataSource: StatsRemoteDataSource {
    func stats(params: StatsParams) -> AnyPublisher<StatsDTO, CharlesDataError> {
        let stats = StatsDTO(month: "2022-4", expense: 234.23, count: 5, categories: [
            .init(categoryId: "0", expense: 123, averageExpense: 152.3, percentageExpense: 0.25, count: 3, averageCount: 5, percentageCount: 0.6),
            .init(categoryId: "1", expense: 8795.12, averageExpense: 1234, percentageExpense: 0.9, count: 2, averageCount: 1, percentageCount: 0.4)
        ])
        return Just(stats)
            .setFailureType(to: CharlesDataError.self)
            .eraseToAnyPublisher()
    }
    
    func historic(params: HistoricParams) -> AnyPublisher<[MonthStatsDTO], CharlesDataError> {
        let stats: [MonthStatsDTO] = [
            .init(month: "2022-01", expense: 123.23),
            .init(month: "2022-02", expense: 654),
            .init(month: "2022-03", expense: 2.65)
        ]
        return Just(stats)
            .setFailureType(to: CharlesDataError.self)
            .eraseToAnyPublisher()
    }
}

class MockErrorStatsRemoteDataSource: StatsRemoteDataSource {
    
    func stats(params: StatsParams) -> AnyPublisher<StatsDTO, CharlesDataError> {
        let error = CharlesDataError(type: .badRequest)
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
    
    func historic(params: HistoricParams) -> AnyPublisher<[MonthStatsDTO], CharlesDataError> {
        let error = CharlesDataError(type: .badRequest)
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
}
