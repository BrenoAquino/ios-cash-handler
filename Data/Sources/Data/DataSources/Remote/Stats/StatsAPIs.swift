//
//  StatsAPIs.swift
//  
//
//  Created by Breno Aquino on 24/04/22.
//

import Foundation

enum StatsAPIs {
    case stats(params: StatsParams)
    case historic(numberOfMonths: Int)
}

extension StatsAPIs: APIs {
    var baseURL: String {
        return HostConfig.shared.environment.baseURL
    }
    
    var path: String {
        switch self {
        case .stats:
            return "stats"
        case .historic:
            return "stats/historic"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .stats, .historic:
            return .get
        }
    }
    
    var queryParams: [String : Any]? {
        switch self {
        case .stats(let params):
            return try? params.asDictionary()
        case .historic(let numberOfMonths):
            return ["number_of_months": numberOfMonths]
        }
    }
    
    var body: Data? {
        return nil
    }
}
