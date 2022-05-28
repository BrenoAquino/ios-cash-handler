//
//  CharlesDataError.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation

public struct CharlesError: Error {
    
    // MARK: Types
    public enum ErrorType {
        case networkError
        case invalidConvertion
        case unkown
        
        // MARK: Create Operation
        case wrongInputType
    }
    
    // MARK: Variables
    public private(set) var type: ErrorType
    
    // MARK: Inits
    public init(type: ErrorType) {
        self.type = type
    }
}
