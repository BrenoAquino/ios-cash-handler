//
//  DSCornerRadius.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

typealias DSCornerRadius = DesignSystem.DSCornerRadius

extension DesignSystem {
    
    struct DSCornerRadius {
        var rawValue: CGFloat
        
        /// Corner Radius - 4
        static let easy: DSCornerRadius = DSCornerRadius(rawValue: 4)
        /// Corner Radius - 8
        static let normal: DSCornerRadius = DSCornerRadius(rawValue: 8)
        /// Corner Radius - 16
        static let hard: DSCornerRadius = DSCornerRadius(rawValue: 16)
    }
}
