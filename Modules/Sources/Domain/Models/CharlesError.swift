//
//  CharlesDataError.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation

public struct CharlesError: Error {
    
    // MARK: Types
    public enum ErrorType: Int {
        // MARK: Network
        case invalidURL = -21
        case invalidResponse = -22
        case badRequest = 400
        case internalError = 500
        
        // MARK: Flow
        case unkown = -11
        case invalidDecoding = -12
    }
    
    // MARK: Variables
    public private(set) var type: ErrorType
    
    // MARK: Inits
    public init(type: ErrorType) {
        self.type = type
    }
    
    public init(networkCode: Int) {
        self.type = ErrorType(rawValue: networkCode) ?? .unkown
    }
}
