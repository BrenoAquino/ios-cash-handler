//
//  File.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation

public extension DateFormatter {
    
    convenience init(pattern: String) {
        self.init()
        dateFormat = pattern
    }
}

public extension Date {
    
    static func components(day: Int, month: Int, year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return Calendar(identifier: .gregorian).date(from: dateComponents)
    }
}

public extension Date {
    
    static func monthName(month: Int) -> String {
        let formatter = DateFormatter(pattern: "MMMM")
        formatter.locale = Locale.preferred
        return formatter.monthSymbols[month - 1]
    }
}
