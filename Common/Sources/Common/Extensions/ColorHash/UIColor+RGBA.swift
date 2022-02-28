//
//  UIColor+RGBA.swift
//  
//
//  Created by Breno Aquino on 27/02/22.
//

import UIKit

public extension UIColor {
    convenience init(rgba: UInt32) {
        let red = Double((rgba >> 24) & 0xff) / 255.0
        let green = Double((rgba >> 16) & 0xff) / 255.0
        let blue = Double((rgba >> 8) & 0xff) / 255.0
        let alpha = Double((rgba) & 0xff) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
