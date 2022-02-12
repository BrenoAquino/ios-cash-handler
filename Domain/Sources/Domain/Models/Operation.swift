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
    public let id: String
    public let title: String
    public let value: Double
    public let date: Date
    public let paymentMethod: PaymentMethod
    public let category: Category
    
    public init(id: String, title: String, value: Double, date: Date, paymentMethod: PaymentMethod, category: Category) {
        self.id = id
        self.title = title
        self.value = value
        self.date = date
        self.paymentMethod = paymentMethod
        self.category = category
    }
}
