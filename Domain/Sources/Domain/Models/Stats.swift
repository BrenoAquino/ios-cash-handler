//
//  Stats.swift
//  
//
//  Created by Breno Aquino on 28/04/22.
//

import Foundation

public struct Stats {
    public let month: Date
    public let expense: Double
    public let categories: [CategoryStats]
    
    public init(month: Date, expense: Double, categories: [CategoryStats]) {
        self.month = month
        self.expense = expense
        self.categories = categories
    }
}
