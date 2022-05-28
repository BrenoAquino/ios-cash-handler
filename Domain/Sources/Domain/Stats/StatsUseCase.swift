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
        let statsHandler: ([Category]) -> AnyPublisher<Stats, CharlesError> = { [weak self] categories in
            guard let self = self else {
                return Fail(error: CharlesError(type: .unkown)).eraseToAnyPublisher()
            }
            
            let currentMonth = Date().componentes([.month, .year])
            return self.statsRepository
                .stats(month: currentMonth.month ?? .zero, year: currentMonth.year ?? .zero, categories: categories)
                .eraseToAnyPublisher()
        }
        
        return categoriesRepository
            .categories()
            .map(statsHandler)
            .switchToLatest()
            .eraseToAnyPublisher()
    }
    
    // MARK: Historic
    public func historic(numberOfMonths: Int) -> AnyPublisher<[MonthStats], CharlesError> {
        let formatter = DateFormatter(pattern: "yyyy-MM-dd")
        let endDate = Date()
        let startDate = Calendar.current.date(byAdding: .month, value: -numberOfMonths, to: endDate) ?? Date()
        return statsRepository
            .historic(startDate: formatter.string(from: startDate), endDate: formatter.string(from: endDate))
            .map { $0.sorted(by: { $0.month < $1.month }) }
            .eraseToAnyPublisher()
    }
}
