//
//  DSButton.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

struct DSButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(DSColor.primaryText.rawValue)
                .font(DSFont.button.rawValue)
        }.background(DSColor.clear.rawValue)
    }
}

struct DSButton_Previews: PreviewProvider {
    static var previews: some View {
        DSButton(title: "Example Button") {}
    }
}
