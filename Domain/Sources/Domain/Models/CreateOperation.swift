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
}
