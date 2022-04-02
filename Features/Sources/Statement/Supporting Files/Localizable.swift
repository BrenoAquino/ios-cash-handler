//
//  Localizable.swift
//  
//
//  Created by Breno Aquino on 10/01/22.
//

import Foundation
import DesignSystem

typealias StatementLocalizable = Localizable.Statement

extension Localizable {
    
    enum Statement {
        static let title: String = "Extrato"
        
        static let userTitle: String = "Breno Aquino"
        static let companyTitle: String = "Charles Inc."
        static let userInitials: String = "BA"
        
        static func subtitleOperationCell(catengory: String, date: String) -> String { "\(catengory) • \(date)" }
        static func valueDescription(currentInstallments: Int, totalInstallments: Int) -> String { "\(currentInstallments) / \(totalInstallments)" }
    }
}
