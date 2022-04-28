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
        static let title: String = "Overview"
        static func percentageDescription(_ value: String) -> String { "\(value)%"}
        static func average(_ value: String) -> String { "\(value) / mês" }
    }
}
