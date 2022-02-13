//
//  PaymentMethodPickerUI.swift
//  
//
//  Created by Breno Aquino on 13/02/22.
//

import Foundation

struct PaymentMethodPickerUI: Identifiable, Hashable {
    let id: Int
    let name: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}

extension PaymentMethodPickerUI {
    static let placeholder = PaymentMethodPickerUI(id: -1, name: "Ex: Cartão de Crédito")
}
