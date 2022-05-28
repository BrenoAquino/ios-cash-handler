//
//  DSBlurRadius.swift
//  
//
//  Created by Breno Aquino on 28/05/22.
//

import SwiftUI

public typealias DSBlurRadius = DesignSystem.DSBlurRadius

public extension DesignSystem {
    
    struct DSBlurRadius {
        public var rawValue: CGFloat
        
        /// Corner Radius - 4
        public static let easy: DSBlurRadius = DSBlurRadius(rawValue: 8)
        /// Corner Radius - 8
        public static let normal: DSBlurRadius = DSBlurRadius(rawValue: 16)
        /// Corner Radius - 16
        public static let hard: DSBlurRadius = DSBlurRadius(rawValue: 24)
    }
}
