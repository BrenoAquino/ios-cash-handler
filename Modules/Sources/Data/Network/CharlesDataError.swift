//
//  CharlesDataError.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation

public struct CharlesDataError: Error {
    public enum ErrorType {
        // MARK: Network
        case invalidURL
        case invalidResponse
        case unsuccessCode(statusCode: Int)
    }
    
    public private(set) var type: ErrorType
}
