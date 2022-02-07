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
    public let category: String
    public let paymentMethod: String
    public let value: Double
    
    private enum CodingKeys : String, CodingKey {
        case id, title, date, category, value
        case paymentMethod = "payment_method"
    }
}

public extension OperationDTO {
    func toDomain() -> Domain.Operation {
        return Domain.Operation()
    }
}
