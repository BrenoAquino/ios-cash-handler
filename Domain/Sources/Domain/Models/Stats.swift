//
//  Stats.swift
//  
//
//  Created by Breno Aquino on 28/04/22.
//

import Foundation

public struct Stats {
    public let month: Int
    public let year: Int
    public let expense: Double
    public let categories: [CategoryStats]
    
    public init(month: Int, year: Int, expense: Double, categories: [CategoryStats]) {
        self.month = month
        self.year = year
        self.expense = expense
        self.categories = categories
    }
}
