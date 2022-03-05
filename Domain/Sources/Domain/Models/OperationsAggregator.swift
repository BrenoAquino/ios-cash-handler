//
//  OperationsAggregator.swift
//  
//
//  Created by Breno Aquino on 04/03/22.
//

import Foundation

public struct OperationsAggregator {
    public let month: Int
    public let year: Int
    public private(set) var operations: [Operation]
    
    internal var dateToCompate: Date {
        return Date.components(day: 1, month: month, year: year) ?? .distantFuture
    }
    
    public init(month: Int, year: Int, operations: [Operation] = []) {
        self.month = month
        self.year = year
        self.operations = operations
    }
    
    internal mutating func addOperation(_ operation: Operation) {
        operations.append(operation)
    }
}
