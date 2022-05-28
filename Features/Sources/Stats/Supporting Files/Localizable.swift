//
//  Localizable.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import Foundation
import DesignSystem

typealias StatsLocalizable = Localizable.Stats

extension Localizable {
    
    enum Stats {
        static let title: String = "Estatísticas"
        static func percentageDescription(_ value: String) -> String { "\(value)%"}
        static func average(_ value: String) -> String { "\(value) / mês" }
        static let categoryTitleSection: String = "Categorias"
        
        // MARK: CategoryStatsView
        static let expenseTitle: String = "Gasto"
        static let countTitle: String = "Quantidade"
        static let totalSubtitle: String = "Total"
        static let averageSubtitle: String = "Média (M-1)"
        
        // MARK: MonthStatsView
        static let totalIncome: String = "Total Entrada"
        static let totalExpense: String = "Total Saída"
        static let percentageLastMonth: String = "Acréscimo"
    }
}
