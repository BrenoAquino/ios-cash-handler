//
//  NumberFormatter+inThousands.swift
//  
//
//  Created by Breno Aquino on 17/04/22.
//

import Foundation

public extension NumberFormatter {
    static func inThousands(number: Int) -> String {
        return inThousands(number: Double(number))
    }
    
    static func inThousands(number: Double) -> String {
        let numberOfThousands = number / 1_000
        return String(format: "%.1fK", numberOfThousands)
    }
}
