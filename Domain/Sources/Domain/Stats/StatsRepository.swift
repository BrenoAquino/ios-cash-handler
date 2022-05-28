//
//  StatsRepository.swift
//  
//
//  Created by Breno Aquino on 24/04/22.
//

import Foundation
import Combine

public protocol StatsRepository {
    func historic(startDate: String, endDate: String) -> AnyPublisher<[MonthStats], CharlesError>
    func stats(month: Int, year: Int, categories: [Category]) -> AnyPublisher<Stats, CharlesError>
}
