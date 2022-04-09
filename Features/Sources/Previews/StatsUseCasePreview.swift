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
    
    public func monthOverview(month: Int, year: Int) -> AnyPublisher<MonthOverview, CharlesError> {
        return Just(Domain.MonthOverview(month: month, year: year, expense: 1234.7))
            .setFailureType(to: CharlesError.self)
            .eraseToAnyPublisher()
    }
    
    public func categories(month: Int, year: Int) -> AnyPublisher<[CategoryOverview], CharlesError> {
        return Just([
            .init(categoryId: "1", categoryName: "Tecnologia", expense: 123.32, count: 12, expensePercentage: 0.3, countPercentage: 0.1)
        ])
            .setFailureType(to: CharlesError.self)
            .eraseToAnyPublisher()
    }
}
#endif
