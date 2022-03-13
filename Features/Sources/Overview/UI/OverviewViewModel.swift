//
//  File.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import Foundation
import Combine
import DesignSystem
import Domain

private let categoriesOpetions: [CategoryOverviewUI.PaymentMethodUI] = [
    .init(title: "Cartão de Crédito", isSelected: false),
    .init(title: "Vale Refeição", isSelected: false),
    .init(title: "Vale Alimentação", isSelected: false),
    .init(title: "Transferência Bancária", isSelected: false),
    .init(title: "Cartão de Débito", isSelected: false)
]

public extension OverviewView {
    
    final class ViewModel: ObservableObject {
        
        private let operationsUseCase: Domain.OperationsUseCase
        private var operations: [Domain.Operation] = []
        private var cancellables: Set<AnyCancellable> = .init()
        
        private let currentMonth: (month: Int, year: Int)
        let month: String
        let year: String
        
        // MARK: Publisher
        @Published var banner: BannerControl = .init(show: false, data: .empty)
        @Published private(set) var stateHandler: ViewStateHandler = .init(state: .loading)
        @Published private(set) var overviewMonth: OverviewMonthUI = .init(income: .empty, expense: .empty, refer: .empty)
        @Published private(set) var categories: [CategoryOverviewUI] = [
            .init(title: "Tecnologia".uppercased(), expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3, paymentMethods: categoriesOpetions),
            .init(title: "Saúde".uppercased(), expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3, paymentMethods: categoriesOpetions),
            .init(title: "Lazer".uppercased(), expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3, paymentMethods: categoriesOpetions),
            .init(title: "Educação".uppercased(), expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3, paymentMethods: categoriesOpetions),
            .init(title: "Refeição".uppercased(), expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3, paymentMethods: categoriesOpetions),
            .init(title: "Mobilidade".uppercased(), expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3, paymentMethods: categoriesOpetions),
            .init(title: "Moradia".uppercased(), expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3, paymentMethods: categoriesOpetions),
            .init(title: "Outras Pessoas".uppercased(), expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3, paymentMethods: categoriesOpetions)
        ]
        
        // MARK: Redirects
        
        // MARK: - Inits
        public init(operationsUseCase: Domain.OperationsUseCase) {
            self.operationsUseCase = operationsUseCase
            
            self.month = DateFormatter(pattern: "MMMM").string(from: .now).capitalized
            self.year = DateFormatter(pattern: "yyyy").string(from: .now)
            
            let components = Calendar.current.dateComponents([.month, .year], from: .now)
            self.currentMonth = (components.month ?? .zero, components.year ?? .zero)
        }
    }
}

// MARK: - Setups
extension OverviewView.ViewModel {
    private func setupErrorBanner(error: CharlesError) {
        banner.data = .init(title: Localizable.Common.failureTitleBanner,
                            subtitle: error.localizedDescription,
                            type: .failure)
        banner.show = true
    }
    
    private func setupOverview() {
        let total = operations.reduce(.zero, { $0 + $1.value })
        let totalString = String(format: "R$ %.2f", total)
        overviewMonth = .init(income: "N/D", expense: totalString, refer: "N/D")
    }
}

// MARK: - Flow
extension OverviewView.ViewModel {
    func fetchOperations() {
        stateHandler.loading()
        operationsUseCase
            .operations(month: currentMonth.month, year: currentMonth.year)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.stateHandler.finished()
                case .failure(let error):
                    self?.setupErrorBanner(error: error)
                    self?.stateHandler.failure()
                }
            } receiveValue: { [weak self] operations in
                self?.operations = operations
                self?.setupOverview()
            }
            .store(in: &cancellables)
    }
}

// MARK: - Actions
extension OverviewView.ViewModel {
}
