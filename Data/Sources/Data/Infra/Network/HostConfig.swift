//
//  HostConfig.swift
//  
//
//  Created by Breno Aquino on 27/02/22.
//

import Foundation

class HostConfig {
    
    enum Environment {
        case dev
        case prd
        
        var baseURL: String {
            switch self {
            case .dev:
                return "https://tqcbp1qk03.execute-api.us-east-1.amazonaws.com/dev/cash-management"
            case .prd:
                return ""
            }
        }
    }
    
    static let shared: HostConfig = .init()
    let environment: Environment = .prd
    
    private init() {}
}
