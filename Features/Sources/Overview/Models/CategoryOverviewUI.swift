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
    let expensePercentage: Double
    let count: String
    let countPercentage: Double
    
    init(categoryOverview: Domain.CategoryOverview) {
        self.title = categoryOverview.categoryName
        
        self.expense = NumberFormatter.currency.string(for: categoryOverview.expense) ?? .empty
        self.expensePercentage = categoryOverview.expensePercentage
        self.count = OverviewLocalizable.totalCount(number: String(categoryOverview.count)) 
        self.countPercentage = categoryOverview.countPercentage
    }
    
    init(title: String, expense: String, expensePercentage: Double, count: String, countPercentage: Double) {
        self.title = title
        self.expense = expense
        self.expensePercentage = expensePercentage
        self.count = count
        self.countPercentage = countPercentage
    }
}
