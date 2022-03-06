//
//  MaskedTextField.swift
//  
//
//  Created by Breno Aquino on 06/03/22.
//

import SwiftUI

public struct MaskedTextField: UIViewRepresentable {
    
    let maskedTextField: MaskedUITextField
    
    public init(placeholder: String? = nil, formatter: @escaping (_ text: String?) -> String?, text: Binding<String>) {
        maskedTextField = MaskedUITextField(placeholder: placeholder, formatter: formatter, text: text)
    }
    
    public func makeUIView(context: Context) -> MaskedUITextField {
        return maskedTextField
    }
    
    public func updateUIView(_ uiView: MaskedUITextField, context: Context) { }
}

#if DEBUG
// MARK: - Preview
struct MaskedTextField_Previews: PreviewProvider {
    
    static var previews: some View {
        MaskedTextField(value: .constant(0))
    }
}
#endif
