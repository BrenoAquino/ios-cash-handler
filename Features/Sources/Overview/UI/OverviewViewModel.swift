//
//  File.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import Combine
import DesignSystem
import Domain

public extension OverviewView {
    
    final class ViewModel: ObservableObject {
        
        // MARK: Publisher
        @Published private(set) var month: String = "Março"
        @Published private(set) var year: String = "2022"
        @Published private(set) var overviewMonth: OverviewMonthUI = .init(
            income: "R$ 32K",
            expense: "R$ 4,32K",
            refer: "+5,32%"
        )
        @Published private(set) var categories: [[CategoryOverviewUI]] = [
            [.init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3),
             .init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3)],
            [.init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3),
             .init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3)],
            [.init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3),
             .init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3)],
            [.init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3),
             .init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3)],
            [.init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3)]
        ]
        @Published private(set) var data: [CircleChartData] = [
            .init(title: "Lazer", value: 1, color: .orange),
            .init(title: "Tecnologia", value: 2, color: .yellow),
            .init(title: "Refeição", value: 3, color: .purple),
            .init(title: "Educação", value: 4, color: .gray),
        ]
        
        // MARK: Redirects
        
        // MARK: - Inits
        public init() {}
    }
}

// MARK: - Setups
extension OverviewView.ViewModel {
}

// MARK: - Flow
extension OverviewView.ViewModel {
}

// MARK: - Actions
extension OverviewView.ViewModel {
}
