//
//  Operation.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import Foundation

public enum OperationType {
    case cashIn
    case cashOut
}

public struct Operation: Identifiable {
    public let id: String
    public let title: String
    
    public init(id: String, title: String) {
        self.id = id
        self.title = title
    }
}
