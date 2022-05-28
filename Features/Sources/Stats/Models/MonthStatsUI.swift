//
//  MonthStatsUI.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import Foundation
import Domain

struct MonthStatsUI {
    let income: String
    let expense: String
    let refer: String
    
    init(stats: Domain.Stats) {
        income = "N/A"
        refer = "N/A"
        
        let value = NumberFormatter.currency.string(for: stats.expense)
        self.expense = value ?? .empty
    }
    
    init(income: String, expense: String, refer: String) {
        self.income = income
        self.expense = expense
        self.refer = refer
    }
}

extension MonthStatsUI {
    static let placeholder = MonthStatsUI(income: .empty, expense: .empty, refer: .empty)
}
