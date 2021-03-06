//
//  Localizable.swift
//  
//
//  Created by Breno Aquino on 10/01/22.
//

import Foundation

public enum Localizable {
    
    public enum Common {
        public static let cancel: String = "Cancelar"
        public static let failureTitleBanner: String = "Something went wrong"
        public static func currency(_ value: String) -> String { "R$ \(value)" }
    }
}
