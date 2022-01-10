//
//  View+Placeholder.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

struct PlaceholderStyle: ViewModifier {
    var showPlaceholder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceholder {
                Text(placeholder)
                    .font(DSFont.input.rawValue)
                    .foregroundColor(DSColor.placholder.rawValue)
            }
            content
        }
    }
}
