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
    
    public init(statsRepository: StatsRepository) {
        self.statsRepository = statsRepository
    }
}

// MARK: Interfaces
extension StatsUseCaseImpl: StatsUseCase {
    
    // MARK: Stats
    public func stats() -> AnyPublisher<Stats, CharlesError> {
        let currentMonth = Date().componentes([.month, .year])
        return statsRepository
            .stats(month: currentMonth.month ?? .zero, year: currentMonth.year ?? .zero)
            .eraseToAnyPublisher()
    }
    
    // MARK: Historic
    public func historic(numberOfMonths: Int) -> AnyPublisher<[MonthStats], CharlesError> {
        return statsRepository
            .historic(numberOfMonths: numberOfMonths)
            .eraseToAnyPublisher()
    }
}
