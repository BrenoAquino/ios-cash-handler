//
//  ColumnsChartConfig.swift
//  
//
//  Created by Breno Aquino on 16/04/22.
//

import SwiftUI

public struct ColumnsChartConfig {
    public var min: CGFloat
    public var max: CGFloat
    public let verticalTitles: [String]
    public var values: [ColumnsValue]
    
    // MARK: Inits
    public init(max: CGFloat, min: CGFloat, verticalTitles: [String], values: [ColumnsValue] = []) {
        self.max = max
        self.min = min
        self.verticalTitles = verticalTitles
        self.values = values
    }
    
    // MARK: Values
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
}
