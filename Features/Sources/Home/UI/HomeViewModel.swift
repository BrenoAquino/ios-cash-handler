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
import SwiftUI

public extension HomeView {
    
    final class ViewModel: ObservableObject {
        
        private let categoriesUseCase: Domain.CategoriesUseCase
        private let paymentMethodsUseCase: Domain.PaymentMethodsUseCase
        private let operationsUseCase: Domain.OperationsUseCase
        private var cancellables: Set<AnyCancellable> = .init()
        
        // MARK: Publisher
        @Published private(set) var state: ViewState = .loading
        @Published var operationOptions: Bool = false
        @Published var operations: [OperationUI] = []
        
        // MARK: Redirects
        public var selectAddOperation: ((Domain.OperationType) -> Void)?
        
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
        withAnimation {
            state = .loading
        }
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
                    withAnimation {
                        self?.state = .failure
                    }
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
                    withAnimation {
                        self?.state = .finished
                    }
                case .failure:
                    withAnimation {
                        self?.state = .failure
                    }
                }
            } receiveValue: { [weak self] operations in
                self?.operations = operations.map { OperationUI(operation: $0) }
            }
            .store(in: &cancellables)
    }
}

// MARK: - Actions
extension HomeView.ViewModel {
    func selectAdd() {
        operationOptions = true
    }
    
    func addCashIn() {
        operationOptions = false
        selectAddOperation?(.cashIn)
    }
    
    func addCashOut() {
        operationOptions = false
        selectAddOperation?(.cashOut)
    }
    
    func addCancel() {
        operationOptions = false
    }
}
