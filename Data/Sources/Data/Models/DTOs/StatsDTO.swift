//
//  StatsDTO.swift
//  
//
//  Created by Breno Aquino on 24/04/22.
//

import Foundation
import Domain

public struct StatsDTO: Decodable {
    public let month: Int
    public let year: Int
    public let expense: Double
    public let categories: [CategoryStatsDTO]
}

extension StatsDTO {
    func toDomain(categories: [Domain.Category]) throws -> Domain.Stats {
        let categories = try self.categories.map { try $0.toDomain(categories: categories) }
        return Domain.Stats(month: month, year: year, expense: expense, categories: categories)
    }
}
