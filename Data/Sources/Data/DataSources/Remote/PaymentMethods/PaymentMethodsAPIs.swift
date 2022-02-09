//
//  PaymentMethodsAPIs.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation

enum PaymentMethodsAPIs {
    case paymentMethod
}

extension PaymentMethodsAPIs: APIs {
    var baseURL: String {
        return "https://tqcbp1qk03.execute-api.us-east-1.amazonaws.com/dev/cash-management"
    }
    
    var path: String {
        switch self {
        case .paymentMethod:
            return "payment-methods"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .paymentMethod:
            return .get
        }
    }
    
    var body: Data? {
        switch self {
        case .paymentMethod:
            return nil
        }
    }
}
