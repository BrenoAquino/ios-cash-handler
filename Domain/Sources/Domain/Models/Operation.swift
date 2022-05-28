//
//  Operation.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation

public struct Operation {
    public let id: String
    public let name: String
    public let value: Double
    public let date: Date
    public let paymentMethod: PaymentMethod
    public let category: Category
    public let currentInstallments: Int?
    public let totalInstallments: Int?
    public let operationAggregatorId: String?
    
    public init(id: String,
                name: String,
                value: Double,
                date: Date,
                paymentMethod: PaymentMethod,
                category: Category,
                currentInstallments: Int? = nil,
                totalInstallments: Int? = nil,
                operationAggregatorId: String? = nil) {
        self.id = id
        self.name = name
        self.value = value
        self.date = date
        self.paymentMethod = paymentMethod
        self.category = category
        self.currentInstallments = currentInstallments
        self.totalInstallments = totalInstallments
        self.operationAggregatorId = operationAggregatorId
    }
}
