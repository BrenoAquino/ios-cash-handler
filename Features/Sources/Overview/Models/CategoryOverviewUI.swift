//
//  CategoryOverviewUI.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import Foundation
import Domain

struct CategoryOverviewUI: Hashable, Identifiable {
    var id: String { title }
    
    let title: String
    let expense: String
    let averageExpense: String
    let percentageExpenseDescription: String
    let percentageExpense: Double
    let othersPercentage: Double
    let count: String
    let averageCount: String
    
    init(categoryStats: Domain.CategoryStats) {
        self.title = categoryStats.categoryName.capitalized
        
        self.expense = NumberFormatter.currency.string(for: categoryStats.expense) ?? .empty
        self.averageExpense = OverviewLocalizable.average(NumberFormatter.currency.string(for: categoryStats.averageExpense) ?? .empty)
        self.percentageExpenseDescription = OverviewLocalizable.percentageDescription(String(Int(categoryStats.percentageExpense * 100)))
        self.percentageExpense = categoryStats.percentageExpense
        self.othersPercentage = .one - categoryStats.percentageExpense
        self.count = String(categoryStats.count)
        self.averageCount = OverviewLocalizable.average(String(categoryStats.averageCount))
    }
    
    init(title: String,
         expense: String,
         averageExpense: String,
         percentageExpenseDescription: String,
         percentageExpense: Double,
         othersPercentage: Double,
         count: String,
         averageCount: String) {
        self.title = title
        self.expense = expense
        self.averageExpense = averageExpense
        self.percentageExpenseDescription = percentageExpenseDescription
        self.percentageExpense = percentageExpense
        self.othersPercentage = othersPercentage
        self.count = count
        self.averageCount = averageCount
    }
}

