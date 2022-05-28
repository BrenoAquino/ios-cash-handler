//
//  StatsUseCasePreview.swift
//  
//
//  Created by Breno Aquino on 09/04/22.
//

#if DEBUG
import Foundation
import Combine
import Domain

// MARK: UseCase
public class StatsUseCasePreview: StatsUseCase {
    
    public init() {}
    
    public func stats() -> AnyPublisher<Stats, CharlesError> {
        let categories: [CategoryStats] = [
            .init(categoryId: "1",
                  categoryName: "Tecnologia",
                  expense: 2352.90,
                  averageExpense: 1121.45,
                  percentageExpense: 0.82,
                  count: 1,
                  averageCount: 2,
                  percentageCount: 0.12),
            .init(categoryId: "2",
                  categoryName: "Saúde",
                  expense: 270,
                  averageExpense: 520,
                  percentageExpense: 0.1,
                  count: 2,
                  averageCount: 1,
                  percentageCount: 0.25),
            .init(categoryId: "0",
                  categoryName: "Lazer",
                  expense: 234.23,
                  averageExpense: 523.72,
                  percentageExpense: 0.08,
                  count: 5,
                  averageCount: 5,
                  percentageCount: 0.63)
        ]
        let stats = Domain.Stats(month: Date.components(day: 1, month: 1, year: 2022)!, expense: 2857.13, categories: categories)
        return Just(stats)
            .setFailureType(to: CharlesError.self)
            .eraseToAnyPublisher()
    }
    
    public func historic(numberOfMonths: Int) -> AnyPublisher<[MonthStats], CharlesError> {
        return Just([
            Domain.MonthStats(month: Date.components(day: 1, month: 3, year: 2022)!, expense: 1234.7),
            Domain.MonthStats(month: Date.components(day: 1, month: 2, year: 2022)!, expense: 782.17),
            Domain.MonthStats(month: Date.components(day: 1, month: 1, year: 2022)!, expense: 53.3)
        ])
        .setFailureType(to: CharlesError.self)
        .eraseToAnyPublisher()
    }
}
#endif
