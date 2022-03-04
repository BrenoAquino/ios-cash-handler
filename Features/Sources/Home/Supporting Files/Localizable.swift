//
//  Localizable.swift
//  
//
//  Created by Breno Aquino on 10/01/22.
//

import Foundation
import DesignSystem

typealias HomeLocalizable = Localizable.Home

extension Localizable {
    
    enum Home {
        static let homeTitle: String = "Home"
        
        static let userTitle: String = "Breno Aquino"
        static let companyTitle: String = "Charles Inc."
        static let userInitials: String = "BA"
        
        static let operationOptionsTitle: String = "Tipo de operação a ser adicionada"
        static let cashInOption: String = "Cash In"
        static let cashOutOption: String = "Cash Out"
        
        static func subtitleOperationCell(catengory: String, date: String) -> String { "\(catengory) • \(date)" }
    }
}
