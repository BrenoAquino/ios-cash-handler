//
//  OperationsAPIs.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Common

enum OperationsAPIs {
    case operations(params: OperationsFilterParams?)
    case addOperation(params: CreateOperationParams)
}

extension OperationsAPIs: APIs {
    var baseURL: String {
        return HostConfig.shared.environment.baseURL
    }
    
    var path: String {
        switch self {
        case .operations, .addOperation:
            return "operations"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .operations:
            return .get
        case .addOperation:
            return .post
        }
    }
    
    var queryParams: [String : Any]? {
        switch self {
        case .operations(let params):
            return try? params?.asDictionary()
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .operations:
            return nil
        case .addOperation(let params):
            return try? JSONEncoder().encode(params)
        }
    }
}
