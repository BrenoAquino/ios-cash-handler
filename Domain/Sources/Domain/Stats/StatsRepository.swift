//
//  StatsRepository.swift
//  
//
//  Created by Breno Aquino on 24/04/22.
//

import Foundation
import Combine
import Common

public protocol StatsRepository {
    func historic(numberOfMonths: Int) -> AnyDataPubliher<[MonthStats], CharlesError>
    func stats(month: Int, year: Int, categories: [Category]) -> AnyDataPubliher<Stats, CharlesError>
}
