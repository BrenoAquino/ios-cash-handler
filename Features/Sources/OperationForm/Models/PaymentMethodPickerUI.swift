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
    let hasInstallments: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(hasInstallments)
    }
}

extension PaymentMethodPickerUI {
    static let placeholder = PaymentMethodPickerUI(id: .empty, name: "Ex: Cartão de Crédito", hasInstallments: false)
}
