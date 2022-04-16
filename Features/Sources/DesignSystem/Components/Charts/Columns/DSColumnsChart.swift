//
//  DSColumnsChart.swift
//  
//
//  Created by Breno Aquino on 10/04/22.
//

import SwiftUI

typealias DSColumnsChart = DesignSystem.DSColumnsChart

extension DesignSystem {
    
    enum DSColumnsChart {
        static let columnHeight: CGFloat = 48
        static let columnWidth: CGFloat = 12
        static let verticalAxisWidth: CGFloat = 40
        static let horizontalAxisHeight: CGFloat = 40
        
        // MARK: Columns
        static let columnGradientColors: [Color] = [DSColor.main.rawValue,
                                                    DSColor.main.rawValue.opacity(0.5),
                                                    DSColor.main.rawValue.opacity(.zero)]
        
        // MARK: ColumnsVerticalAxis
        static let dashLineWidth: CGFloat = 1
        static let dashLineHeight: CGFloat = 1
        static let dashLineConfig: [CGFloat] = [10, 20]
        
        // MARK: ColumnsSelection
        static let arrowWidth: CGFloat = 20
        static let arrowHeight: CGFloat = 10
    }
}
