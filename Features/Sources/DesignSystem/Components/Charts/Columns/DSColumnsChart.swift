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
        static let columnHeight: CGFloat = 64
        static let columnWidth: CGFloat = 12
        static let verticalAxisWidth: CGFloat = 40
        static let horizontalAxisHeight: CGFloat = 40
        
        // MARK: Columns
        static let columnGradientColors: [Color] = [.black, .black.opacity(0.5), .black.opacity(.zero)]
    }
}
