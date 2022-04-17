//
//  OperationsFilterParams.swift
//  
//
//  Created by Breno Aquino on 13/03/22.
//

import Foundation

public struct OperationsFilterParams {
    
    let month: Int?
    let year: Int?
    
    let startMonth: Int?
    let startYear: Int?
    let endMonth: Int?
    let endYear: Int?
    
    var param: Encodable? {
        if let filterByMonth = filterByMonth {
            return filterByMonth
        } else if let interval = interval {
            return interval
        }
        return nil
    }
    
    var filterByMonth: MonthFilter? {
        return MonthFilter(month: month, year: year)
    }
    
    var interval: IntervalFilter? {
        return IntervalFilter(startMonth: startMonth, startYear: startYear, endMonth: endMonth, endYear: endYear)
    }
    
    internal init(month: Int? = nil,
                  year: Int? = nil,
                  startMonth: Int? = nil,
                  startYear: Int? = nil,
                  endMonth: Int? = nil,
                  endYear: Int? = nil) {
        self.month = month
        self.year = year
        self.startMonth = startMonth
        self.startYear = startYear
        self.endMonth = endMonth
        self.endYear = endYear
    }
    
    public struct MonthFilter: Encodable {
        let month: Int
        let year: Int
        
        internal init?(month: Int?, year: Int?) {
            guard let month = month, let year = year else { return nil }
            self.month = month
            self.year = year
        }
    }
    
    public struct IntervalFilter: Encodable {
        let startMonth: Int
        let startYear: Int
        let endMonth: Int
        let endYear: Int
        
        internal init?(startMonth: Int?, startYear: Int?, endMonth: Int?, endYear: Int?) {
            guard let startMonth = startMonth, let startYear = startYear, let endMonth = endMonth, let endYear = endYear else { return nil }
            self.startMonth = startMonth
            self.startYear = startYear
            self.endMonth = endMonth
            self.endYear = endYear
        }
    }
}
