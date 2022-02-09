//
//  Operation.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Domain

public struct OperationDTO: Decodable {
    public let id: String
    public let title: String
    public let date: String
    public let categoryId: Int
    public let paymentMethodId: Int
    public let value: Double
    
    private enum CodingKeys : String, CodingKey {
        case id, title, date, value
        case categoryId = "category_id"
        case paymentMethodId = "payment_method_id"
    }
}

public extension OperationDTO {
    func toDomain() -> Domain.Operation {
        return Domain.Operation(title: .empty,
                                value: .zero,
                                date: .now,
                                paymentMethod: .init(id: .zero, name: .empty),
                                category: .init(id: .zero, name: .empty))
    }
}
