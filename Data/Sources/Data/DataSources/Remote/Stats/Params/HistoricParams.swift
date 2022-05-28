//
//  HistoricParams.swift
//  
//
//  Created by Breno Aquino on 28/05/22.
//

import Foundation

public struct HistoricParams: Encodable {
    let startDate: String
    let endDate: String
    
    private enum CodingKeys : String, CodingKey {
        case startDate = "start_date"
        case endDate = "end_date"
    }
}
