//
//  StatsRepository.swift
//  
//
//  Created by Breno Aquino on 24/04/22.
//

import Foundation
import Combine

public protocol StatsRepository {
    func historic(numberOfMonths: Int) -> AnyPublisher<[MonthStats], CharlesError>
    func stats(month: Int, year: Int) -> AnyPublisher<Stats, CharlesError>
}
