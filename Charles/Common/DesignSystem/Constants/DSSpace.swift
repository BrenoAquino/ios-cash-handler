//
//  DSSpace.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

typealias DSSpace = DesignSystem.DSSpace

extension DesignSystem {
    
    struct DSSpace {
        
        var rawValue: CGFloat
        
        /// Big Large - 40
        static let bigL: DSSpace = DSSpace(rawValue: 40)
        /// Big Medium - 32
        static let bigM: DSSpace = DSSpace(rawValue: 32)
        /// Big Small - 28
        static let bigS: DSSpace = DSSpace(rawValue: 28)
        /// Normal - 24
        static let normal: DSSpace = DSSpace(rawValue: 24)
        /// Small Large - 16
        static let smallL: DSSpace = DSSpace(rawValue: 16)
        /// Small Medium - 8
        static let smallM: DSSpace = DSSpace(rawValue: 8)
        /// Small Small - 4
        static let smallS: DSSpace = DSSpace(rawValue: 4)
        /// Zero - 0
        static let zero: DSSpace = DSSpace(rawValue: 0)
        /// Custom
        static func custom(_ value: CGFloat) -> DSSpace { DSSpace(rawValue: value) }
        /// Negative Constants
        static prefix func -(value: DSSpace) -> DSSpace {
            return DSSpace(rawValue: -value.rawValue)
        }
    }
}
