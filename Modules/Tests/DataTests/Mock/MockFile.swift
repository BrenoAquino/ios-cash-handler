//
//  MockFile.swift
//  
//
//  Created by Breno Aquino on 06/02/22.
//

import Foundation

@testable import Data

enum MockFile: String {
    
    // MARK: Operations
    // App Operation
    case addOperstionSuccess = "add_operation_success"
    case addOperstionError = "add_operation_error"
    case addOperstionEncodingError = "add_operation_encoding_error"
}

// MARK: Load File
extension MockFile {
    private func dataFromFile(name: String) -> Data {
        if let file = Bundle.module.url(forResource: name, withExtension: "json") {
            let json = try? String(contentsOf: file, encoding: .utf8)
            return json?.data(using: .utf8) ?? Data()
        }
        return "".data(using: .utf8) ?? Data()
    }
    
    var data: Data {
        return dataFromFile(name: rawValue)
    }
}
