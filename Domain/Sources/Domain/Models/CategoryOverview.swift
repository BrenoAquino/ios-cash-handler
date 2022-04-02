//
//  CategoryOverview.swift
//  
//
//  Created by Breno Aquino on 02/04/22.
//

import Foundation

public struct CategoryOverview {
    public let categoryId: String
    public let categoryName: String
    public let expense: Double
    public let count: Int
    
    public let expensePercentage: Double
    public let countPercentage: Double
    
    public init(categoryId: String, categoryName: String, expense: Double, count: Int, expensePercentage: Double, countPercentage: Double) {
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.expense = expense
        self.count = count
        self.expensePercentage = expensePercentage
        self.countPercentage = countPercentage
    }
}
