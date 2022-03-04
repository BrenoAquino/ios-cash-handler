//
//  PaymentMethodEntity.swift
//  
//
//  Created by Breno Aquino on 12/02/22.
//

import Foundation
import Domain

public struct PaymentMethodEntity: Entity {
    public let primaryKey: String
    public let name: String
    public let hasInstallments: Bool
}

public extension PaymentMethodEntity {
    func toDomain() -> Domain.PaymentMethod {
        return Domain.PaymentMethod(id: primaryKey, name: name)
    }
}
