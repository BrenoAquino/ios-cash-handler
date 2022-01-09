//
//  InputTextField.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

struct InputTextField: View {
    
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: DSSpace.smallS.rawValue) {
            Text(title)
                .foregroundColor(DSColor.primaryText.rawValue)
                .font(DSFont.caption1.rawValue)
            TextField("Placeholder", text: $text)
                .foregroundColor(DSColor.primaryText.rawValue)
                .font(DSFont.input.rawValue)
                .placeholder(when: text.isEmpty) {
                    Text(placeholder)
                        .font(DSFont.input.rawValue)
                        .foregroundColor(DSColor.placholder.rawValue)
                }
        }
        .padding()
        .background(DSColor.secondBackground.rawValue)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct InputTextField_Previews: PreviewProvider {
    static var previews: some View {
        InputTextField(title: "Email", placeholder: "example@mail.com", text: .constant(""))
    }
}
