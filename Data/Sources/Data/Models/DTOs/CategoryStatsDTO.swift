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
    public let count: Int
    public let averageCount: Int
    
    private enum CodingKeys : String, CodingKey {
        case expense, count
        case categoryId = "category_id"
        case averageExpense = "average_expense"
        case averageCount = "average_count"
    }
}
