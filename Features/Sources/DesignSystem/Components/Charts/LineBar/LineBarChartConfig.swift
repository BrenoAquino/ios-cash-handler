//
//  LineBarChartConfig.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import SwiftUI

public struct LineBarChartConfig {
    public let percentage: Double
    public let color: Color
    public let backgroundColor: Color
    
    public init(percentage: Double, color: Color, backgroundColor: Color) {
        self.percentage = percentage
        self.color = color
        self.backgroundColor = backgroundColor
    }
}
