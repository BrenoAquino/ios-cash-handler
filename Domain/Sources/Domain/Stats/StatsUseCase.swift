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
    func monthOverview(month: Int, year: Int) -> AnyPublisher<MonthOverview, CharlesError>
    func categories(month: Int, year: Int) -> AnyPublisher<[CategoryOverview], CharlesError>
    func historic(numberOfMonths: Int) -> AnyPublisher<[MonthOverview], CharlesError>
}

// MARK: Implementation
public final class StatsUseCaseImpl {
    
    private let operationsRepository: OperationsRepository
    
    public init(operationsRepository: OperationsRepository) {
        self.operationsRepository = operationsRepository
    }
}

// MARK: Utils
extension StatsUseCaseImpl {
    private func operations(month: Int?, year: Int?) -> AnyPublisher<[Operation], CharlesError> {
        return operationsRepository
            .operations(month: month, year: year)
            .eraseToAnyPublisher()
    }
}

// MARK: Interfaces
extension StatsUseCaseImpl: StatsUseCase {
    
    // MARK: Overview
    public func monthOverview(month: Int, year: Int) -> AnyPublisher<MonthOverview, CharlesError> {
        return operations(month: month, year: year)
            .map { operationsPerMonth in
                let totalExpense = operationsPerMonth.reduce(Double.zero, { $0 + $1.value })
                return MonthOverview(month: month,
                                     year: year,
                                     expense: totalExpense)
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: Cateogries
    public func categories(month: Int, year: Int) -> AnyPublisher<[CategoryOverview], CharlesError> {
        return operations(month: month, year: year)
            .map { operationsPerMonth in
                let totalExpense = operationsPerMonth.reduce(Double.zero, { $0 + $1.value })
                
                var operationsPerCategory: [String : [Operation]] = [:]
                operationsPerMonth.forEach { operationsPerCategory[$0.category.id, default: []].append($0) }
                
                return operationsPerCategory.compactMap { (_, value) in
                    guard let category = value.first?.category else { return nil }
                    let categoryExpense = value.reduce(Double.zero, { $0 + $1.value })
                    
                    return CategoryOverview(categoryId: category.id,
                                            categoryName: category.name,
                                            expense: categoryExpense,
                                            count: value.count,
                                            expensePercentage: categoryExpense / totalExpense,
                                            countPercentage: Double(value.count) / Double(operationsPerMonth.count))
                }.sorted(by: { $0.expense > $1.expense })
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: Historic
    public func historic(numberOfMonths: Int) -> AnyPublisher<[MonthOverview], CharlesError> {
        let endData = Date()
        let startDate = Calendar.current.date(byAdding: .month, value: -numberOfMonths, to: endData) ?? Date()
        
        let endDateComponents = Calendar.current.dateComponents([.month, .year], from: endData)
        let startDateComponents = Calendar.current.dateComponents([.month, .year], from: startDate)
        
        return operationsRepository
            .operations(startMonth: startDateComponents.month ?? .zero,
                        startYear: startDateComponents.year ?? .zero,
                        endMonth: endDateComponents.month ?? .zero,
                        endYear: endDateComponents.year ?? .zero)
            .map { operations in
                var operationsPerMonth: [Date : [Operation]] = [:]
                operations.forEach { operationsPerMonth[$0.date.firstDayMonth, default: []].append($0) }
                
                return operationsPerMonth.compactMap { (key, value) in
                    let components = Calendar.current.dateComponents([.month, .year], from: key)
                    let totalExpense = value.reduce(Double.zero, { $0 + $1.value })
                    
                    return MonthOverview(month: components.month ?? .zero,
                                         year: components.year ?? .zero,
                                         expense: totalExpense)
                }
            }
            .eraseToAnyPublisher()
    }
}
