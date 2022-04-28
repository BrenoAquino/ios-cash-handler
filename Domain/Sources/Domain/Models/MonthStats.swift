//
//  MonthStats.swift
//  
//
//  Created by Breno Aquino on 02/04/22.
//

import Foundation

public struct MonthStats {
    public let month: Int
    public let year: Int
    public let expense: Double
    
    public init(month: Int, year: Int, expense: Double) {
        self.month = month
        self.year = year
        self.expense = expense
    }
}
