//
//  OperationsAggregatorUI.swift
//  
//
//  Created by Breno Aquino on 04/03/22.
//

import Foundation
import Domain
import DesignSystem

struct OperationsAggregatorUI: Identifiable {
    var id: String { month + year }
    
    let month: String
    let year: String
    let operations: [OperationUI]
    
    init?(operationsAggregator: Domain.OperationsAggregator) {
        guard operationsAggregator.month >= 1 && operationsAggregator.month <= 12 else { return nil }
        self.month = Date.monthName(month: operationsAggregator.month)
        self.year = String(operationsAggregator.year)
        self.operations = operationsAggregator.operations.map { OperationUI(operation: $0) }
    }
}

extension OperationsAggregatorUI: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(month)
        hasher.combine(year)
    }
    
    static func == (lhs: OperationsAggregatorUI, rhs: OperationsAggregatorUI) -> Bool {
        return lhs.month == rhs.month && lhs.year == rhs.year
    }
}
