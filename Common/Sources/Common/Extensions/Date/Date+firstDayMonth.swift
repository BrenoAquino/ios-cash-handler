//
//  Date+firstDayMonth.swift
//  
//
//  Created by Breno Aquino on 16/04/22.
//

import Foundation

public extension Date {
    var firstDayMonth: Date {
        let components = Calendar.current.dateComponents([.month, .year], from: self)
        let firstDayMonth = Date.components(day: .one, month: components.month ?? .zero, year: components.year ?? .zero)
        return firstDayMonth ?? .distantPast
    }
}
