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
    public let categoryId: String
    public let paymentMethodId: String
    public let value: Double
    public let currentInstallments: Int?
    public let totalInstallments: Int?
    public let operationAggregatorId: String?
    
    private enum CodingKeys : String, CodingKey {
        case id, title, date, value
        case categoryId = "category_id"
        case paymentMethodId = "payment_method_id"
        case currentInstallments = "current_installments"
        case totalInstallments = "total_installments"
        case operationAggregatorId = "operation_aggregator_id"
    }
}

extension OperationDTO {
    func toDomain(paymentMethods: [Domain.PaymentMethod], categories: [Domain.Category]) throws -> Domain.Operation {
        guard let date = DateFormatter(pattern: "dd-MM-yyyy").date(from: date),
              let paymentMethod = paymentMethods.first(where: { $0.id == paymentMethodId }),
              let category = categories.first(where: { $0.id == categoryId }) else {
                  throw CharlesDataError(type: .invalidDomainConverter)
              }
        
        return Domain.Operation(id: id,
                                title: title,
                                value: value,
                                date: date,
                                paymentMethod: paymentMethod,
                                category: category,
                                currentInstallments: currentInstallments,
                                totalInstallments: totalInstallments,
                                operationAggregatorId: operationAggregatorId)
    }
}
