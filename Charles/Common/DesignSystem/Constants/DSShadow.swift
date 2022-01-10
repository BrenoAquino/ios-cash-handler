//
//  DSShadow.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

typealias DSShadow = DesignSystem.DSShadow

extension DesignSystem {
    
    struct DSShadow {
        
        var color: Color
        var radius: CGFloat
        
        /// Big Large - 40
        static let easy: DSShadow = DSShadow(color: DSColor.easyShadow.rawValue, radius: 8)
        /// Big Medium - 32
        static let medium: DSShadow = DSShadow(color: DSColor.shadow.rawValue, radius: 16)
    }
}

// MARK: - Extensions
extension View {
    
    func shadow(style: DSShadow) -> some View {
        return shadow(color: style.color, radius: style.radius)
    }
}
