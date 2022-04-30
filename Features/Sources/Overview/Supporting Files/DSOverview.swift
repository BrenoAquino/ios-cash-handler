//
//  DSOverview.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import SwiftUI
import DesignSystem

typealias DSOverview = DesignSystem.DSOverview

extension DesignSystem {
    
    enum DSOverview {
        static let categoryOverviewLineHeight: CGFloat = 2
        static let numberOfVerticalTitles: Int = 5
        static let heightColumns: CGFloat = 336
        
        // MARK: CategoryOverviewView
        static let categoryOverviewWidth: CGFloat = 280
        static let percentageExapenseSize: CGSize = .init(width: 36, height: 36)
        static let percentageExapenseStrokeMin: CGFloat = 2
        static let percentageExapenseStrokeDiff: CGFloat = 1
    }
}
