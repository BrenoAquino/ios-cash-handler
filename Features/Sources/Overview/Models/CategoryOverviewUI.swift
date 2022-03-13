//
//  CategoryOverviewUI.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import Foundation

struct CategoryOverviewUI: Hashable {
    let title: String
    let expense: String
    let expensePercentage: Double
    let count: String
    let countPercentage: Double
    let paymentMethods: [PaymentMethodUI]
    
    struct PaymentMethodUI: Hashable, Identifiable {
        var id: String { title }
        
        let title: String
        var isSelected: Bool
    }
}
