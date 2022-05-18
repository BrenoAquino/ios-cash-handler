//
//  StatsUseCase.swift
//
//
//  Created by Breno Aquino on 09/04/22.
//

import Foundation
import Combine
import Common

public protocol StatsUseCase {
    func stats() -> AnyPublisher<Stats, CharlesError>
    func historic(numberOfMonths: Int) -> AnyPublisher<[MonthStats], CharlesError>
}

// MARK: Implementation
public final class StatsUseCaseImpl {
    
    private let statsRepository: StatsRepository
    private let categoriesRepository: CategoriesRepository
    
    public init(statsRepository: StatsRepository,
                categoriesRepository: CategoriesRepository) {
        self.statsRepository = statsRepository
        self.categoriesRepository = categoriesRepository
    }
}

// MARK: Interfaces
extension StatsUseCaseImpl: StatsUseCase {
    
    // MARK: Stats
    public func stats() -> AnyPublisher<Stats, CharlesError> {
        let currentMonth = Date().componentes([.month, .year])
        return categoriesRepository
            .categories()
            .map { categories -> AnyPublisher<Stats, CharlesError> in
                let month = currentMonth.month ?? .zero
                let year = currentMonth.year ?? .zero
                return self.statsRepository
                    .stats(month: month, year: year, categories: categories)
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }
    
    // MARK: Historic
    public func historic(numberOfMonths: Int) -> AnyPublisher<[MonthStats], CharlesError> {
        return statsRepository
            .historic(numberOfMonths: numberOfMonths)
            .map { historic in
                return historic.sorted { lhs, rhs in
                    let lhsDate = Date.components(day: .one, month: lhs.month, year: lhs.year) ?? .distantPast
                    let rhsDate = Date.components(day: .one, month: rhs.month, year: rhs.year) ?? .distantPast
                    return lhsDate < rhsDate
                }
            }
            .eraseToAnyPublisher()
    }
}
