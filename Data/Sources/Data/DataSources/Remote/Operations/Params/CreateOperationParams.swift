//
//  CreateOperationParams.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation

public struct CreateOperationParams: Encodable {
    let title: String
    let date: String
    let value: Double
    let categoryId: Int
    let paymentMethodId: Int
    
    private enum CodingKeys : String, CodingKey {
        case title, date, value
        case categoryId = "category_id"
        case paymentMethodId = "payment_method_id"
    }
}
