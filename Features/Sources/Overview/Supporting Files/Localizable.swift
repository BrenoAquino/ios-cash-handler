//
//  Localizable.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import Foundation
import DesignSystem

typealias OverviewLocalizable = Localizable.Overview

extension Localizable {
    
    enum Overview {
        static func totalCount(number: String) -> String { "\(number) compras" }
    }
}
