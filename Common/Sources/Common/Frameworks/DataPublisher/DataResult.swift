//
//  DataResult.swift
//  
//
//  Created by Breno Aquino on 02/05/22.
//

import Foundation

public enum DataResult<Output, Failure> where Failure: Error {
    case data(data: Output)
    case error(error: Failure)
    
    // MARK: Maps
    public func mapData<T>(_ transform: (Output) -> T) -> DataResult<T, Failure> {
        switch self {
        case .data(let data):
            return .data(data: transform(data))
        case .error(let error):
            return .error(error: error)
        }
    }
    
    public func mapError<T>(_ transform: (Failure) -> T) -> DataResult<Output, T> where T: Error {
        switch self {
        case .data(let data):
            return .data(data: data)
        case .error(let error):
            return .error(error: transform(error))
        }
    }
}
