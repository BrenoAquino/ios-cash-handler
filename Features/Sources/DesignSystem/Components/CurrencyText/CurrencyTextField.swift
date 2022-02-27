//
//  CurrencyTextField.swift
//  
//
//  Created by Breno Aquino on 27/02/22.
//

import SwiftUI

public struct CurrencyTextField: UIViewRepresentable {
    
    let currencyField: CurrencyUITextField
    
    public init(value: Binding<Double>) {
        currencyField = CurrencyUITextField(value: value)
    }
    
    public func makeUIView(context: Context) -> CurrencyUITextField {
        return currencyField
    }
    
    public func updateUIView(_ uiView: CurrencyUITextField, context: Context) { }
}

#if DEBUG
// MARK: - Preview
struct CurrencyTextField_Previews: PreviewProvider {
    
    static var previews: some View {
        CurrencyTextField(value: .constant(0))
    }
}
#endif
