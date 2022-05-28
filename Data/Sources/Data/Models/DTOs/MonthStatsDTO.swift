//
//  MonthStatsDTO.swift
//  
//
//  Created by Breno Aquino on 24/04/22.
//

import Foundation
import Domain

public struct MonthStatsDTO: Decodable {
    public let month: String
    public let expense: Double
}

extension MonthStatsDTO {
    func toDomain() throws -> Domain.MonthStats {
        guard let month = DateFormatter(pattern: "yyyy-MM").date(from: month) else {
            throw CharlesDataError(type: .invalidDomainConverter)
        }
        
        return Domain.MonthStats(month: month, expense: expense)
    }
}
