//
//  PaymentMethodDTO.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Domain

public struct PaymentMethodDTO: Decodable {
    public let id: Int
    public let name: String
}

public extension PaymentMethodDTO {
    func toDomain() -> Domain.PaymentMethod {
        return Domain.PaymentMethod(id: id, name: name)
    }
    
    func toEntity() -> PaymentMethodEntity {
        return PaymentMethodEntity(primaryKey: id, name: name)
    }
}
