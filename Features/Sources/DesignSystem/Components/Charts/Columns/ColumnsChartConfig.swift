//
//  ColumnsChartConfig.swift
//  
//
//  Created by Breno Aquino on 16/04/22.
//

import SwiftUI

public struct ColumnsChartConfig {
    public let min: CGFloat
    public let max: CGFloat
    public let axes: ColumnsAxesConfig
    
    public init(max: CGFloat, min: CGFloat, axes: ColumnsAxesConfig) {
        self.max = max
        self.min = min
        self.axes = axes
    }
    
    public struct ColumnsAxesConfig {
        public let vertical: [String]
        public let horizontal: [String]
        
        public init(vertical: [String], horizontal: [String]) {
            self.vertical = vertical
            self.horizontal = horizontal
        }
    }
}
