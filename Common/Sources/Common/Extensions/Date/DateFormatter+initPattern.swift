//
//  DateFormatter+initPattern.swift
//  
//
//  Created by Breno Aquino on 16/04/22.
//

import Foundation

public extension DateFormatter {
    convenience init(pattern: String) {
        self.init()
        dateFormat = pattern
    }
}
