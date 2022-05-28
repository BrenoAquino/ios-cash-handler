//
//  StatsDTO.swift
//  
//
//  Created by Breno Aquino on 24/04/22.
//

import Foundation
import Domain

public struct StatsDTO: Decodable {
    public let month: String
    public let expense: Double
    public let count: Int
    public let categories: [CategoryStatsDTO]
}

extension StatsDTO {
    func toDomain(categories: [Domain.Category]) throws -> Domain.Stats {
        guard let month = DateFormatter(pattern: "yyyy-MM").date(from: month) else {
            throw CharlesDataError(type: .invalidDomainConverter)
        }
        
        let categories = try self.categories.map { try $0.toDomain(categories: categories) }
        return Domain.Stats(month: month, expense: expense, categories: categories)
    }
}
