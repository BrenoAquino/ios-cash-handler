//
//  Color+RGBA.swift
//  
//
//  Created by Breno Aquino on 27/02/22.
//

import SwiftUI

public extension Color {
    init(rgba: UInt32) {
        let red = Double((rgba >> 24) & 0xff) / 255.0
        let green = Double((rgba >> 16) & 0xff) / 255.0
        let blue = Double((rgba >> 8) & 0xff) / 255.0
        let opacity = Double((rgba) & 0xff) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
