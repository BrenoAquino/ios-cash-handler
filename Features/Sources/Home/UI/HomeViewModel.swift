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
        private let paymentMethods: Domain.PaymentMethodsUseCase
        private var cancellables: Set<AnyCancellable> = .init()
        
        // MARK: Publisher
        @Published var operationOptions: Bool = false
        @Published var operations: [String] = ["Breno", "Pinheiro", "Aquino"]
        @Published private(set) var state: ViewState = .loading
        
        // MARK: Redirects
        public var selectAddOperation: ((Domain.OperationType) -> Void)?
        
        // MARK: Inits
        public init(categoriesUseCase: Domain.CategoriesUseCase,
                    paymentMethods: Domain.PaymentMethodsUseCase) {
            self.categoriesUseCase = categoriesUseCase
            self.paymentMethods = paymentMethods
            
            fetchCategoriesAndPaymentMethods()
        }
        
        // MARK: Flow
        private func fetchCategoriesAndPaymentMethods() {
            let categoriesPublisher = categoriesUseCase.categories()
            let paymentMethodsPublisher = paymentMethods.paymentMethods()
            
            categoriesPublisher
                .zip(paymentMethodsPublisher)
                .receive(on: RunLoop.main)
                .sinkCompletion { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.state = .finished
                    case .failure:
                        self?.state = .failure
                    }
                }
                .store(in: &cancellables)
        }
        
        // MARK: Actions
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
}
