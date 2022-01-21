//
//  DSSpace.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

public typealias DSSpace = DesignSystem.DSSpace

public extension DesignSystem {
    
    struct DSSpace {
        
        public var rawValue: CGFloat
        
        /// Big Large - 40
        public static let bigL: DSSpace = DSSpace(rawValue: 40)
        /// Big Medium - 32
        public static let bigM: DSSpace = DSSpace(rawValue: 32)
        /// Big Small - 28
        public static let bigS: DSSpace = DSSpace(rawValue: 28)
        /// Normal - 24
        public static let normal: DSSpace = DSSpace(rawValue: 24)
        /// Small Large - 16
        public static let smallL: DSSpace = DSSpace(rawValue: 16)
        /// Small Medium - 8
        public static let smallM: DSSpace = DSSpace(rawValue: 8)
        /// Small Small - 4
        public static let smallS: DSSpace = DSSpace(rawValue: 4)
        /// Zero - 0
        public static let zero: DSSpace = DSSpace(rawValue: 0)
        /// Custom
        public static func custom(_ value: CGFloat) -> DSSpace { DSSpace(rawValue: value) }
        /// Negative Constants
        public static prefix func -(value: DSSpace) -> DSSpace {
            return DSSpace(rawValue: -value.rawValue)
        }
    }
}
