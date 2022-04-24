//
//  MonthStatsDTO.swift
//  
//
//  Created by Breno Aquino on 24/04/22.
//

import Foundation
import Domain

public struct MonthStatsDTO: Decodable {
    public let month: Int
    public let year: Int
    public let expense: Double
}
