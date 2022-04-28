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
    case addOperstionDecodingError = "add_operation_decoding_error"
    // Operations
    case operationsSuccess = "operations_success"
    case operationsDecodingError = "operations_decoding_error"
    
    // MARK: Categories
    // Categories
    case categoriesSuccess = "categories_success"
    case categoriesDecodingError = "categories_decoding_error"
    
    // MARK: PaymentMethods
    // PaymentMethods
    case paymentMethodsSuccess = "payment_methods_success"
    case paymentMethodsDecodingError = "payment_methods_decoding_error"
    
    // MARK: Stats
    // Stats
    case statsSuccess = "stats_success"
    case statsDecodingError = "stats_decoding_error"
    // Historic
    case historicSuccess = "historic_success"
    case historicDecodingError = "historic_decoding_error"
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
