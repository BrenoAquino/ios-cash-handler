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
    let expensePercentageDescription: String
    let expensePercentage: Double
    let othersPercentage: Double
    
    let count: String
    
    init(categoryOverview: Domain.CategoryOverview) {
        self.title = categoryOverview.categoryName.capitalized
        
        self.expense = NumberFormatter.currency.string(for: categoryOverview.expense) ?? .empty
        self.expensePercentageDescription = String(Int(categoryOverview.expensePercentage * 100)) + "%"
        self.expensePercentage = categoryOverview.expensePercentage
        self.othersPercentage = .one - categoryOverview.expensePercentage
        
        self.count = String(categoryOverview.count)
        
        print(title, expensePercentage, othersPercentage, expensePercentage + othersPercentage)
    }
    
    init(title: String, expense: String, expensePercentageDescription: String, expensePercentage: Double, othersPercentage: Double, count: String) {
        self.title = title
        self.expense = expense
        self.expensePercentageDescription = expensePercentageDescription
        self.expensePercentage = expensePercentage
        self.othersPercentage = othersPercentage
        self.count = count
    }
}
