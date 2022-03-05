//
//  DateAggregator.swift
//  
//
//  Created by Breno Aquino on 04/03/22.
//

import Foundation

public struct DateAggregator: Hashable {
    public let month: Int
    public let year: Int
    
    public var dateToCompate: Date {
        return Date.components(day: 1, month: month, year: year) ?? .distantFuture
    }
    
    public init?(date: Date) {
        let components = Calendar.current.dateComponents([.month, .year], from: date)
        guard let month = components.month, let year = components.year else { return nil }
        self.month = month
        self.year = year
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(month)
        hasher.combine(year)
    }
}
