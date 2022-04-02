//
//  OverviewMonthUI.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import Foundation
import Domain

struct OverviewMonthUI {
    let income: String
    let expense: String
    let refer: String
    
    init(monthOverview: Domain.MonthOverview) {
        income = "N/A"
        refer = "N/A"
        
        let value = NumberFormatter.currency.string(for: monthOverview.expense)
        self.expense = value ?? .empty
    }
    
    init(income: String, expense: String, refer: String) {
        self.income = income
        self.expense = expense
        self.refer = refer
    }
}

extension OverviewMonthUI {
    static let placeholder = OverviewMonthUI(income: .empty, expense: .empty, refer: .empty)
}
