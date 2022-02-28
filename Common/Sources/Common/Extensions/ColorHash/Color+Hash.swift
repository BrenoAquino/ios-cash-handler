//
//  File.swift
//  
//
//  Created by Breno Aquino on 27/02/22.
//

import SwiftUI
import UIKit

fileprivate func generateColorFor(text: String) -> UInt32 {
    var hash: Int = 0
    let colorConstant = 131
    let maxSafeValue = Int.max / colorConstant
    for char in text.unicodeScalars {
        if hash > maxSafeValue {
            hash = hash / colorConstant
        }
        hash = Int(char.value) + ((hash << 5) - hash)
    }
    return UInt32(abs(hash) % (256 * 256 * 256))
}

public extension Color {
    static func generate(by string: String) -> Color {
        let hash = generateColorFor(text: string)
        return Color(rgba: hash)
    }
}

public extension UIColor {
    static func generate(by string: String) -> UIColor {
        let hash = generateColorFor(text: string)
        return UIColor(rgba: hash)
    }
}
