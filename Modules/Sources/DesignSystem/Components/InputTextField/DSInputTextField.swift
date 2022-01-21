//
//  DSInputTextField.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

public struct DSInputTextField: View {
    
    let title: String
    let placeholder: String
    @Binding var text: String
    
    public init(title: String, placeholder: String, text: Binding<String>) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: DSSpace.smallS.rawValue) {
            Text(title)
                .foregroundColor(DSColor.primaryText.rawValue)
                .font(DSFont.caption1.rawValue)
            TextField("", text: $text)
                .foregroundColor(DSColor.primaryText.rawValue)
                .font(DSFont.input.rawValue)
                .modifier(
                    PlaceholderStyle(
                        showPlaceholder: text.isEmpty,
                        placeholder: placeholder
                    )
                )
        }
        .padding()
        .background(DSColor.secondBackground.rawValue)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(style: .easy)
    }
}

struct DSInputTextField_Previews: PreviewProvider {
    static var previews: some View {
        DSInputTextField(title: "Email", placeholder: "example@mail.com", text: .constant(""))
    }
}
