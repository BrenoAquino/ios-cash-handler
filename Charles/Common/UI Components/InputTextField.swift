//
//  InputTextField.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

struct InputTextField: View {
    
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: DSSpace.smallS.rawValue) {
            Text(title)
                .foregroundColor(DSColor.primaryText.rawValue)
                .font(DSFont.caption1.rawValue)
            TextField("Placeholder", text: $text)
                .foregroundColor(DSColor.primaryText.rawValue)
                .font(DSFont.input.rawValue)
        }
        .padding()
        .background(DSColor.secondBackground.rawValue)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct InputTextField_Previews: PreviewProvider {
    static var previews: some View {
        InputTextField(title: "Email", text: .constant("Text"))
    }
}
