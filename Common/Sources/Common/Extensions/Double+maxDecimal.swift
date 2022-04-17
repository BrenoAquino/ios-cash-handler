//
//  Double+maxDecimal.swift
//  
//
//  Created by Breno Aquino on 17/04/22.
//

import Foundation

public extension Double {
    var ceilMaxDecimal: Int {
        var currentDecimal: Int = 1
        var rest: Int = Int(self) / currentDecimal
        
        while rest > .zero {
            currentDecimal *= 10
            rest = Int(self) / currentDecimal
        }
        
        currentDecimal /= 10
        let value = Int(self) / currentDecimal
        return value * currentDecimal
    }
}
