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

public extension OverviewView {
    
    final class ViewModel: ObservableObject {
        
        private let operationsUseCase: Domain.OperationsUseCase
        private var operations: [Domain.Operation] = []
        private var cancellables: Set<AnyCancellable> = .init()
        
        private let currentMonth: Int
        let month: String
        let year: String
        
        // MARK: Publisher
        @Published var banner: BannerControl = .init(show: false, data: .empty)
        @Published private(set) var stateHandler: ViewStateHandler = .init(state: .loading)
        @Published private(set) var overviewMonth: OverviewMonthUI = .init(income: .empty, expense: .empty, refer: .empty)
        @Published private(set) var categories: [[CategoryOverviewUI]] = [
//            [.init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3),
//             .init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3)],
//            [.init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3),
//             .init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3)],
//            [.init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3),
//             .init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3)],
//            [.init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3),
//             .init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3)],
//            [.init(title: "Tecnologia", expense: "R$ 2800", expensePercentage: 0.75, count: "13 compras", countPercentage: 0.3)]
        ]
        
        // MARK: Redirects
        
        // MARK: - Inits
        public init(operationsUseCase: Domain.OperationsUseCase) {
            self.operationsUseCase = operationsUseCase
            
            self.month = DateFormatter(pattern: "MMMM").string(from: .now)
            self.year = DateFormatter(pattern: "yyyy").string(from: .now)
            self.currentMonth = Calendar.current.component(.month, from: .now)
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
            .operations(by: self.currentMonth)
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
