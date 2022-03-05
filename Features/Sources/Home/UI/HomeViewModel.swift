//
//  HomeViewModel.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import Foundation
import Combine
import DesignSystem
import Domain

public extension HomeView {
    
    final class ViewModel: ObservableObject {
        
        private let categoriesUseCase: Domain.CategoriesUseCase
        private let paymentMethodsUseCase: Domain.PaymentMethodsUseCase
        private let operationsUseCase: Domain.OperationsUseCase
        private var cancellables: Set<AnyCancellable> = .init()
        
        // MARK: Publisher
        @Published private(set) var stateHandler: ViewStateHandler = .init(state: .loading)
        @Published private(set) var operations: [OperationsAggregatorUI] = []
        
        // MARK: Redirects
        public var selectAddOperation: (() -> Void)?
        
        // MARK: - Inits
        public init(categoriesUseCase: Domain.CategoriesUseCase,
                    paymentMethods: Domain.PaymentMethodsUseCase,
                    operationsUseCase: Domain.OperationsUseCase) {
            self.categoriesUseCase = categoriesUseCase
            self.paymentMethodsUseCase = paymentMethods
            self.operationsUseCase = operationsUseCase
        }
    }
}

// MARK: - Flow
extension HomeView.ViewModel {
    func fetchDate() {
        stateHandler.loading()
        fetchCategoriesPaymentMethods()
    }
    
    private func fetchCategoriesPaymentMethods() {
        let categoriesPublisher = categoriesUseCase.categories()
        let paymentMethodsPublisher = paymentMethodsUseCase.paymentMethods()
        
        categoriesPublisher
            .zip(paymentMethodsPublisher)
            .receive(on: RunLoop.main)
            .sinkCompletion { [weak self] completion in
                switch completion {
                case .finished:
                    self?.fetchOperations()
                case .failure:
                    self?.stateHandler.failure()
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchOperations() {
        operationsUseCase
            .operations()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.stateHandler.finished()
                case .failure:
                    self?.stateHandler.failure()
                }
            } receiveValue: { [weak self] operations in
                for key in operations.keys.sorted(by: { $0.dateToCompate > $1.dateToCompate }) {
                    guard let values = operations[key],
                          let operationsAggregatorUI = OperationsAggregatorUI(dateAggregator: key, operations: values)
                    else { continue }
                    self?.operations.append(operationsAggregatorUI)
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - Actions
extension HomeView.ViewModel {
    func selectAdd() {
        selectAddOperation?()
    }
}
