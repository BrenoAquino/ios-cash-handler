//
//  CreateOperation.swift
//  
//
//  Created by Breno Aquino on 06/03/22.
//

import Foundation

public struct CreateOperation {
    public let title: String
    public let date: String
    public let value: Double
    public let categoryId: String
    public let paymentMethodId: String
    public let installments: Int?
    
    public init(title: String, date: String, value: Double, categoryId: String, paymentMethodId: String, installments: Int?) {
        self.title = title
        self.date = date
        self.value = value
        self.categoryId = categoryId
        self.paymentMethodId = paymentMethodId
        self.installments = installments
    }
}
