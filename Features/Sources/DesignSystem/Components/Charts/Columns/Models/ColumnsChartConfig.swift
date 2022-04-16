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
}
