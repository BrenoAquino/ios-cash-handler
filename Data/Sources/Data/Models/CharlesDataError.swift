//
//  CharlesDataError.swift
//  
//
//  Created by Breno Aquino on 06/02/22.
//

import Foundation
import Domain

public struct CharlesDataError: Error {
    
    // MARK: Types
    public enum ErrorType: Int {
        // MARK: Flow
        case unkown = -11
        case invalidDecoding = -12
        
        // MARK: Network
        case invalidURL = -21
        case invalidResponse = -22
        case badRequest = 400
        case internalError = 500
        
        // MARK: Decode
        case invalidKeyPath = -31
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

public extension CharlesDataError {
    func toDomain() -> Domain.CharlesError {
        switch type {
        case .unkown:
            return CharlesError(type: .unkown)
        default:
            return CharlesError(type: .networkError)
        }
    }
}
