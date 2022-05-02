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
    
    public func stats() -> AnyPublisher<Domain.Stats, Domain.CharlesError> {
        let categories: [Domain.Category] = [
            .init(id: "0", name: "Tecnologia"),
            .init(id: "1", name: "Saúde"),
            .init(id: "2", name: "Lazer")
        ]
        let categoriesStats: [Domain.CategoryStats] = [
            .init(category: categories[0], expense: 2352.90, averageExpense: 1121.45, percentageExpense: 0.82, count: 1, averageCount: 2),
            .init(category: categories[1], expense: 270, averageExpense: 520, percentageExpense: 0.1, count: 2, averageCount: 1),
            .init(category: categories[2], expense: 234.23, averageExpense: 523.72, percentageExpense: 0.08, count: 5, averageCount: 5)
        ]
        let stats = Domain.Stats(month: 4, year: 2022, expense: 2857.13, categories: categoriesStats)
        return Just(stats)
            .setFailureType(to: CharlesError.self)
            .eraseToAnyPublisher()
    }
    
    public func historic(numberOfMonths: Int) -> AnyPublisher<[Domain.MonthStats], Domain.CharlesError> {
        return Just([
            Domain.MonthStats(month: 3, year: 2022, expense: 1234.7),
            Domain.MonthStats(month: 2, year: 2022, expense: 782.17),
            Domain.MonthStats(month: 1, year: 2022, expense: 53.3)
        ])
        .setFailureType(to: Domain.CharlesError.self)
        .eraseToAnyPublisher()
    }
}
#endif
