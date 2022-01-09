//
//  DSFont.swift
//  Charles
//
//  Created by Breno Aquino on 03/01/22.
//

import SwiftUI

typealias DSFont = DesignSystem.DSFont

extension DesignSystem {
    struct DSFont {
        public var rawValue: Font
        
        /// System Font - Medium - Size 28
        public static let largeTitle: DSFont = DSFont(rawValue: Font.system(size: 28, weight: .medium, design: .default))
        /// System Font - Medium - Size 20
        public static let title: DSFont = DSFont(rawValue: Font.system(size: 20, weight: .medium, design: .default))
        /// System Font - Regular - Size 18
        public static let headline: DSFont = DSFont(rawValue: Font.system(size: 18, weight: .regular, design: .default))
        /// System Font - Light - Size 12
        public static let subheadline: DSFont = DSFont(rawValue: Font.system(size: 12, weight: .light, design: .default))
        /// System Font - Semibold - Size 12
        public static let caption1: DSFont = DSFont(rawValue: Font.system(size: 14, weight: .semibold, design: .default))
        /// System Font - Light - Size 12
        public static let input: DSFont = DSFont(rawValue: Font.system(size: 14, weight: .light, design: .default))
        /// System Font - Semibold - Size 12
        public static let button: DSFont = DSFont(rawValue: Font.system(size: 14, weight: .semibold, design: .default))
    }
}

// MARK: - Extensions
extension Text {
    
    func font(_ dsFont: DSFont) -> Self {
        return font(dsFont.rawValue)
    }
}
