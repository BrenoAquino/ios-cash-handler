//
//  CategoryStatsUI.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import Foundation
import Domain

struct CategoryStatsUI: Hashable, Identifiable {
    var id: String { name }
    
    let name: String
    let expense: String
    let averageExpense: String
    let percentageExpenseDescription: String
    let percentageExpense: Double
    let othersPercentage: Double
    let count: String
    let averageCount: String
    
    init(categoryStats: Domain.CategoryStats) {
        self.name = categoryStats.categoryName.capitalized
        self.expense = NumberFormatter.currency.string(for: categoryStats.expense) ?? .empty
        self.averageExpense = StatsLocalizable.average(NumberFormatter.currency.string(for: categoryStats.averageExpense) ?? .empty)
        self.percentageExpenseDescription = StatsLocalizable.percentageDescription(String(Int(categoryStats.percentageExpense * 100)))
        self.percentageExpense = categoryStats.percentageExpense
        self.othersPercentage = .one - categoryStats.percentageExpense
        self.count = String(categoryStats.count)
        self.averageCount = StatsLocalizable.average(String(categoryStats.averageCount))
    }
    
    init(name: String,
         expense: String,
         averageExpense: String,
         percentageExpenseDescription: String,
         percentageExpense: Double,
         othersPercentage: Double,
         count: String,
         averageCount: String) {
        self.name = name
        self.expense = expense
        self.averageExpense = averageExpense
        self.percentageExpenseDescription = percentageExpenseDescription
        self.percentageExpense = percentageExpense
        self.othersPercentage = othersPercentage
        self.count = count
        self.averageCount = averageCount
    }
}

extension CategoryStatsUI {
    static let placeholder: CategoryStatsUI = .init(name: "Tecnologia",
                                                    expense: "R$ 2800",
                                                    averageExpense: "R$ 2300 / mês",
                                                    percentageExpenseDescription: "55%",
                                                    percentageExpense: 0.75,
                                                    othersPercentage: 0.25,
                                                    count: "12",
                                                    averageCount: "6")
}
