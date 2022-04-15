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
        static let columnHeight: CGFloat = 75
        static let columnWidth: CGFloat = 16
        
        // MARK: Columns
        static let columnGradientColors: [Color] = [.black, .black.opacity(0.25), .black.opacity(.zero)]
    }
}
