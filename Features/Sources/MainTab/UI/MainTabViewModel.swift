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

public final class MainTabViewModel: ObservableObject {
    
    private let categoriesUseCase: Domain.CategoriesUseCase
    private let paymentMethodsUseCase: Domain.PaymentMethodsUseCase
    private var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: Publishers
    @Published private(set) var state: ViewState = .loading
    
    // MARK: - Inits
    public init(categoriesUseCase: Domain.CategoriesUseCase, paymentMethods: Domain.PaymentMethodsUseCase) {
        self.categoriesUseCase = categoriesUseCase
        self.paymentMethodsUseCase = paymentMethods
    }
}

// MARK: - Flow
extension MainTabViewModel {
    func fetchData() {
        state = .loading
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
                    self?.state = .content
                case .failure:
                    self?.state = .failure
                }
            }
            .store(in: &cancellables)
    }
}
