//
//  DSColor.swift
//  Charles
//
//  Created by Breno Aquino on 03/01/22.
//

import SwiftUI

typealias DSColor = DesignSystem.DSColor

extension Color {
    init(rgba: UInt32) {
        let red = Double((rgba >> 24) & 0xff) / 255.0
        let green = Double((rgba >> 16) & 0xff) / 255.0
        let blue = Double((rgba >> 8) & 0xff) / 255.0
        let opacity = Double((rgba) & 0xff) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

extension DesignSystem {
    struct DSColor {
        public var rawValue: Color
        
        /// Backgorund - 0x171B1E - 100%
        static let background: DSColor = DSColor(rawValue: Color(rgba: 0x171B1EFF))
        /// Second Background - 0x272932 - 100%
        static let secondBackground: DSColor = DSColor(rawValue: Color(rgba: 0x272932FF))
        /// Primary Text - 0xFFFFFF - 100%
        static let primaryText: DSColor = DSColor(rawValue: Color(rgba: 0xFFFFFFFF))
        /// Placeholder - 0x9397A0 - 100%
        static let placholder: DSColor = DSColor(rawValue: Color(rgba: 0x9397A0FF))
    }
}

// MARK: - Extensions
extension Shape {
    
    func fill(_ dsColor: DSColor) -> some View {
        return fill(dsColor.rawValue)
    }
}
