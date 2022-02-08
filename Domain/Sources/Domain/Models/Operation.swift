//
//  Operation.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation

public enum OperationType: String {
    case cashIn = "cash-in"
    case cashOut = "cash-out"
}

public struct Operation {
    public let title: String
    public let value: Double
    public let date: Date
    public let paymentMethod: PaymentMethod
    public let category: Category
    
    public init(title: String, value: Double, date: Date, paymentMethod: PaymentMethod, category: Category) {
        self.title = title
        self.value = value
        self.date = date
        self.paymentMethod = paymentMethod
        self.category = category
    }
}
