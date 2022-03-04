//
//  OperationUI.swift
//  
//
//  Created by Breno Aquino on 27/02/22.
//

import Foundation
import Domain
import DesignSystem

struct OperationUI: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let value: String
    let paymentMethodId: String
    let valueDescription: String?
    
    init(id: String, title: String, subtitle: String, value: String, paymentMethodId: String, valueDescription: String?) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.value = value
        self.paymentMethodId = paymentMethodId
        self.valueDescription = valueDescription
    }
    
    init(operation: Domain.Operation) {
        self.id = operation.id
        self.title = operation.title
        self.paymentMethodId = operation.paymentMethod.id
        
        let date = DateFormatter(pattern: "dd / MM / yyyy").string(from: operation.date)
        let subtitle = HomeLocalizable.subtitleOperationCell(catengory: operation.category.name, date: date)
        self.subtitle = subtitle
        
        let value = NumberFormatter.currency.string(for: operation.value)
        self.value = value ?? .empty
        
        if let currentInstallments = operation.currentInstallments, let totalInstallments = operation.totalInstallments {
            self.valueDescription = Localizable.Home.valueDescription(currentInstallments: currentInstallments, totalInstallments: totalInstallments)
        } else {
            self.valueDescription = nil
        }
    }
}
