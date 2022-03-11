//
//  SplashViewModel.swift
//  
//
//  Created by Breno Aquino on 11/03/22.
//

import SwiftUI
import Combine
import DesignSystem
import Domain

public extension MainTabView {
    
    final class ViewModel: ObservableObject {
        
        private let categoriesUseCase: Domain.CategoriesUseCase
        private let paymentMethodsUseCase: Domain.PaymentMethodsUseCase
        private var cancellables: Set<AnyCancellable> = .init()
        
        // MARK: Redirects
        public var fetchViews: () -> some View
        
        // MARK: Publishers
        @Published private(set) var stateHandler: ViewStateHandler = .init(state: .loading)
        
        // MARK: - Inits
        public init(categoriesUseCase: Domain.CategoriesUseCase, paymentMethods: Domain.PaymentMethodsUseCase) {
            self.categoriesUseCase = categoriesUseCase
            self.paymentMethodsUseCase = paymentMethods
        }
    }
}

// MARK: - Flow
extension MainTabView.ViewModel {
    func fetchData() {
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
                    self?.fetchViews?()
                    
                case .failure(let error):
                    self?.stateHandler.failure()
                }
            }
            .store(in: &cancellables)
    }
}
