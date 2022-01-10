//
//  DSCornerRadius.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

public typealias DSCornerRadius = DesignSystem.DSCornerRadius

public extension DesignSystem {
    
    struct DSCornerRadius {
        public var rawValue: CGFloat
        
        /// Corner Radius - 4
        public static let easy: DSCornerRadius = DSCornerRadius(rawValue: 4)
        /// Corner Radius - 8
        public static let normal: DSCornerRadius = DSCornerRadius(rawValue: 8)
        /// Corner Radius - 16
        public static let hard: DSCornerRadius = DSCornerRadius(rawValue: 16)
    }
}
