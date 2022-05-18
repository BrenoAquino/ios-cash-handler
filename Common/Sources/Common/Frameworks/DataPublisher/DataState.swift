//
//  DataState.swift
//  
//
//  Created by Breno Aquino on 02/05/22.
//

import Foundation

public enum DataResult<Output, Failure> where Failure: Error {
    case data(data: Output)
    case error(error: Failure)
}
