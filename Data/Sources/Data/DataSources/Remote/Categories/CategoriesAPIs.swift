//
//  CategoriesAPIs.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation

enum CategoriesAPIs {
    case categories
}

extension CategoriesAPIs: APIs {
    var baseURL: String {
        return "https://tqcbp1qk03.execute-api.us-east-1.amazonaws.com/dev/cash-management"
    }
    
    var path: String {
        switch self {
        case .categories:
            return "categories"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .categories:
            return .get
        }
    }
    
    var body: Data? {
        switch self {
        case .categories:
            return nil
        }
    }
}
