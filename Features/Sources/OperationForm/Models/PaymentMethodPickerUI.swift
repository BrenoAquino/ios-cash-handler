//
//  PaymentMethodPickerUI.swift
//  
//
//  Created by Breno Aquino on 13/02/22.
//

import Foundation

struct PaymentMethodPickerUI: Identifiable, Hashable {
    let id: String
    let name: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}

extension PaymentMethodPickerUI {
    static let placeholder = PaymentMethodPickerUI(id: .empty, name: "Ex: Cartão de Crédito")
}
