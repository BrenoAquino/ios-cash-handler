//
//  File.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import Foundation

extension DateFormatter {
    
    public convenience init(pattern: String) {
        self.init()
        dateFormat = pattern
    }
}
