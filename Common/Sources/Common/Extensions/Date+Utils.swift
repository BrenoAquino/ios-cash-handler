//
//  File.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation

extension DateFormatter {
    
    public convenience init(pattern: String) {
        self.init()
        dateFormat = pattern
    }
}

extension Date {
    
    public static func components(day: Int, month: Int, year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return Calendar(identifier: .gregorian).date(from: dateComponents)
    }
}
