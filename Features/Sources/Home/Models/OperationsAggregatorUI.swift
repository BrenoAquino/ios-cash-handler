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
    
    init?(dateAggregator: Domain.DateAggregator, operations: [Domain.Operation]) {
        guard dateAggregator.month >= 1 && dateAggregator.month <= 12 else { return nil }
        self.month = Date.monthName(month: dateAggregator.month)
        self.year = String(dateAggregator.year)
        self.operations = operations.map { OperationUI(operation: $0) }
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
