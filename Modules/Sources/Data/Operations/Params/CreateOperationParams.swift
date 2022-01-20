//
//  CreateOperationParams.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation

struct CreateOperationParams: Encodable {
    let title: String
    let date: String
    let value: Double
    let category: String
    let paymentType: String
    let operationType: String
}
