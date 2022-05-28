//
//  DSStats.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import SwiftUI
import DesignSystem

typealias DSStats = DesignSystem.DSStats

extension DesignSystem {
    
    enum DSStats {
        static let numberOfVerticalTitles: Int = 5
        static let heightColumns: CGFloat = 336
        static let categoryStatsLineHeight: CGFloat = 2
        static let categoryStatsWidth: CGFloat = 280
        static let percentageExapenseSize: CGSize = .init(width: 36, height: 36)
        static let percentageExapenseStrokeMin: CGFloat = 2
        static let percentageExapenseStrokeDiff: CGFloat = 1
    }
}
