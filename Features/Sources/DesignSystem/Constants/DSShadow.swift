//
//  DSShadow.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

public typealias DSShadow = DesignSystem.DSShadow

public extension DesignSystem {
    
    struct DSShadow {
        
        public var color: Color
        public var radius: CGFloat
        
        /// Big Large - 40
        public static let easy: DSShadow = DSShadow(color: DSColor.easyShadow.rawValue, radius: 8)
        /// Big Medium - 32
        public static let medium: DSShadow = DSShadow(color: DSColor.shadow.rawValue, radius: 16)
    }
}

// MARK: - Extensions
public extension View {
    
    func shadow(style: DSShadow) -> some View {
        return shadow(color: style.color, radius: style.radius)
    }
}
