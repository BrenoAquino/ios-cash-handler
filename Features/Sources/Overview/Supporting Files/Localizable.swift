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
        static let categoryTitleSection: String = "Categorias"
        
        // MARK: CategoryOverviewView
        static let expenseTitle: String = "Gasto"
        static let countTitle: String = "Quantidade"
        static let totalSubtitle: String = "Total"
        static let averageSubtitle: String = "Média (M-1)"
        
        // MARK: OverviewMonthView
        static let totalIncome: String = "Total Entrada"
        static let totalExpense: String = "Total Saída"
        static let percentageLastMonth: String = "Acréscimo"
    }
}
