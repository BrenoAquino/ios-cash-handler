//
//  PaymentMethod.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation

public struct PaymentMethod {
    
    public let id: String
    public let name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
