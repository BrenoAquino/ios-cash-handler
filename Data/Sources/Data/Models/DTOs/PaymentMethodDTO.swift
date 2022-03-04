//
//  PaymentMethodDTO.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation
import Domain

public struct PaymentMethodDTO: Decodable {
    public let id: String
    public let name: String
    public let hasInstallments: Bool
    
    private enum CodingKeys : String, CodingKey {
        case id, name
        case hasInstallments = "has_installments"
    }
}

public extension PaymentMethodDTO {
    func toDomain() -> Domain.PaymentMethod {
        return Domain.PaymentMethod(id: id, name: name)
    }
    
    func toEntity() -> PaymentMethodEntity {
        return PaymentMethodEntity(primaryKey: id, name: name, hasInstallments: hasInstallments)
    }
}
