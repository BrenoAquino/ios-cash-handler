//
//  Date+Components.swift
//  
//
//  Created by Breno Aquino on 16/04/22.
//

import Foundation

public extension Date {
    static func components(day: Int, month: Int, year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return Calendar(identifier: .gregorian).date(from: dateComponents)
    }
    
    func componentes(_ componentes: Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(componentes, from: self)
    }
}
