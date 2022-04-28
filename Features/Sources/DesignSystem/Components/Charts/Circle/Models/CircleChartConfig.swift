//
//  CircleChartConfig.swift
//  
//
//  Created by Breno Aquino on 24/04/22.
//

import SwiftUI

public struct CircleChartConfig {
    let hasSubtitle: Bool
    let strokeMin: CGFloat
    let strokeDiff: CGFloat
    
    let data: [CircleChartData]
    
    public init(hasSubtitle: Bool, strokeMin: CGFloat? = nil, strokeDiff: CGFloat? = nil, data: [CircleChartData]) {
        self.hasSubtitle = hasSubtitle
        self.data = data
        self.strokeMin = strokeMin ?? DSCircleChart.strokeMin
        self.strokeDiff = strokeDiff ?? DSCircleChart.strokeDiff
    }
}
