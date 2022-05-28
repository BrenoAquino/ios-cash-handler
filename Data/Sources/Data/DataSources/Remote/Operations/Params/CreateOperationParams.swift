//
//  CreateOperationParams.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation

public struct CreateOperationParams: Encodable {
    let name: String
    let date: String
    let value: Double
    let categoryId: String
    let paymentMethodId: String
    let installments: Int?
    
    private enum CodingKeys : String, CodingKey {
        case name, date, value, installments
        case categoryId = "category_id"
        case paymentMethodId = "payment_method_id"
    }
}
