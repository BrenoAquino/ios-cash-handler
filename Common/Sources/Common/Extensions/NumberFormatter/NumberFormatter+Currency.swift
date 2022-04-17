//
//  NumberFormatter+Currency.swift
//  
//
//  Created by Breno Aquino on 27/02/22.
//

import Foundation

public extension NumberFormatter {
    
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}
