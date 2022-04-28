//
//  CategoryStats.swift
//  
//
//  Created by Breno Aquino on 02/04/22.
//

import Foundation

public struct CategoryStats {
    public let categoryId: String
    public let categoryName: String
    public let expense: Double
    public let averageExpense: Double
    public let percentageExpense: Double
    public let count: Int
    public let averageCount: Int
    
    public init(categoryId: String, categoryName: String, expense: Double, averageExpense: Double, percentageExpense: Double, count: Int, averageCount: Int) {
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.expense = expense
        self.averageExpense = averageExpense
        self.percentageExpense = percentageExpense
        self.count = count
        self.averageCount = averageCount
    }
}
