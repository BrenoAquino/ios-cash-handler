//
//  MonthOverview.swift
//  
//
//  Created by Breno Aquino on 02/04/22.
//

import Foundation

public struct MonthOverview {
    public let month: Int
    public let year: Int
    
    public let expense: Double
    public let categoriesOverviews: [CategoryOverview]
    
    public init(month: Int, year: Int, expense: Double, categoriesOverviews: [CategoryOverview]) {
        self.month = month
        self.year = year
        self.expense = expense
        self.categoriesOverviews = categoriesOverviews
    }
}
