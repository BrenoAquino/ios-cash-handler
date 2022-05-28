//
//  CategoryStatsDTO.swift
//  
//
//  Created by Breno Aquino on 24/04/22.
//

import Foundation
import Domain

public struct CategoryStatsDTO: Decodable {
    public let categoryId: String
    public let expense: Double
    public let averageExpense: Double
    public let percentageExpense: Double
    public let count: Int
    public let averageCount: Double
    public let percentageCount: Double
    
    private enum CodingKeys : String, CodingKey {
        case expense, count
        case categoryId = "category_id"
        case averageExpense = "expense_average"
        case percentageExpense = "expense_percentage"
        case averageCount = "count_average"
        case percentageCount = "count_percentage"
    }
}

extension CategoryStatsDTO {
    func toDomain(categories: [Domain.Category]) throws -> Domain.CategoryStats {
        guard let category = categories.first(where: { $0.id == categoryId }) else {
            throw CharlesDataError(type: .invalidDomainConverter)
        }
        return Domain.CategoryStats(categoryId: categoryId,
                                    categoryName: category.name,
                                    expense: expense,
                                    averageExpense: averageExpense,
                                    percentageExpense: percentageExpense,
                                    count: count,
                                    averageCount: averageCount,
                                    percentageCount: percentageCount)
    }
}
