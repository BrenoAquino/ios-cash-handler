//
//  File.swift
//  
//
//  Created by Breno Aquino on 16/04/22.
//

import Foundation

public struct ColumnsValue {
    public let value: Double
    public let valueFormatted: String
    public let abbreviation: String
    public let fullSubtitle: String
    
    public init(value: Double, valueFormatted: String? = nil, abbreviation: String, fullSubtitle: String) {
        self.value = value
        self.valueFormatted = valueFormatted ?? String(value)
        self.abbreviation = abbreviation
        self.fullSubtitle = fullSubtitle
    }
}
