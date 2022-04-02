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
        return HostConfig.shared.environment.baseURL
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
    
    var queryParams: [String : Any]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .categories:
            return nil
        }
    }
}
