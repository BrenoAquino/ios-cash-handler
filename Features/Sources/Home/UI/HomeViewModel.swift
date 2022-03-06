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
        @Published var banner: BannerControl = .init(show: false, data: .empty)
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

// MARK: - Setups
extension HomeView.ViewModel {
    private func setupErrorBanner(error: CharlesError) {
        banner.data = .init(title: Localizable.Common.failureTitleBanner,
                            subtitle: error.localizedDescription,
                            type: .failure)
        banner.show = true
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
                case .failure(let error):
                    self?.setupErrorBanner(error: error)
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
                case .failure(let error):
                    self?.setupErrorBanner(error: error)
                    self?.stateHandler.failure()
                }
            } receiveValue: { [weak self] operations in
                self?.operations = operations.compactMap { OperationsAggregatorUI(operationsAggregator: $0) }
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
