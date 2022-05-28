//
//  MonthStats.swift
//  
//
//  Created by Breno Aquino on 02/04/22.
//

import Foundation

public struct MonthStats {
    public let month: Date
    public let expense: Double
    
    public init(month: Date, expense: Double) {
        self.month = month
        self.expense = expense
    }
}
