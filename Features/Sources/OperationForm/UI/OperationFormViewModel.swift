//
//  OperationFormViewModel.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI
import Combine
import Common
import Domain
import DesignSystem

public extension OperationFormView {
    
    final class ViewModel: ObservableObject {
        
        private var cancellables: Set<AnyCancellable> = .init()
        private let operationsUseCase: Domain.OperationsUseCase
        private let categoriesUseCase: Domain.CategoriesUseCase
        private let paymentMethodsUseCase: Domain.PaymentMethodsUseCase
        
        // MARK: Gets
        var currency: String { Domain.Currency.brl }
        
        // MARK: Publishers
        @Published var name: String = .empty
        @Published var date: Date = .init()
        @Published var value: Double = .zero
        @Published var category: String = PaymentMethodPickerUI.placeholder.id
        @Published var paymentMethod: String = PaymentMethodPickerUI.placeholder.id
        @Published var installments: String = .empty
        @Published var banner: BannerControl = .init(show: false, data: .empty)
        
        @Published private(set) var categories: [CategoryPickerUI] = []
        @Published private(set) var paymentMethods: [PaymentMethodPickerUI] = []
        @Published private(set) var hasInstallments: Bool = false
        @Published private(set) var isValidCategory: Bool = false
        @Published private(set) var isValidPaymentMethod: Bool = false
        @Published private(set) var validInputs: Bool = false
        @Published private(set) var state: ViewState = .loading
        
        // MARK: Inits
        public init(operationsUseCase: Domain.OperationsUseCase,
                    categoriesUseCase: Domain.CategoriesUseCase,
                    paymentMethodsUseCase: Domain.PaymentMethodsUseCase) {
            self.operationsUseCase = operationsUseCase
            self.categoriesUseCase = categoriesUseCase
            self.paymentMethodsUseCase = paymentMethodsUseCase
            
            setupInputsChecks()
        }
    }
}

// MARK: - Setups
extension OperationFormView.ViewModel {
    private func setupErrorBanner(error: CharlesError) {
        banner.data = .init(title: Localizable.Common.failureTitleBanner,
                            subtitle: error.localizedDescription,
                            type: .failure)
        banner.show = true
    }
    
    private func setupInputsChecks() {
        let inputValidator: () -> Bool = { [weak self] in
            guard let self = self else { return false }
            return !self.name.isEmpty && self.isValidCategory && self.isValidPaymentMethod
        }
        
        $name.sink(receiveValue: { [weak self] _ in self?.validInputs = inputValidator() }).store(in: &cancellables)
        $value.sink(receiveValue: { [weak self] _ in self?.validInputs = inputValidator() }).store(in: &cancellables)
        
        $category
            .sink { [weak self] value in
                self?.isValidCategory = value != CategoryPickerUI.placeholder.id
                self?.validInputs = inputValidator()
            }
            .store(in: &cancellables)
        
        $paymentMethod
            .sink { [weak self] value in
                let paymentMethod = self?.paymentMethods.first(where: { $0.id == value })
                self?.isValidPaymentMethod = value != PaymentMethodPickerUI.placeholder.id
                self?.validInputs = inputValidator()
                self?.hasInstallments = paymentMethod?.hasInstallments == true
            }
            .store(in: &cancellables)
    }
}

// MARK: - Formatters
extension OperationFormView.ViewModel {
    func installmentsFormatter(_ text: String?) -> String? {
        guard let text = text else { return nil }
        if text.starts(with: Localizable.OperationForm.installmentsPrefix) == true {
            return text
        } else {
            return Localizable.OperationForm.installmentsPrefix + text
        }
    }
}

// MARK: - Flows
extension OperationFormView.ViewModel {
    func fetchData() {
        let categories = categoriesUseCase.categories()
        let paymentMethods = paymentMethodsUseCase.paymentMethods()
        
        categories
            .zip(paymentMethods)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .content
                case .failure(let error):
                    self?.setupErrorBanner(error: error)
                    self?.state = .failure
                }
            } receiveValue: { [weak self] result in
                self?.categories = result.0.map { CategoryPickerUI(id: $0.id, name: $0.name) }
                self?.categories.insert(.placeholder, at: .zero)
                self?.paymentMethods = result.1.map { PaymentMethodPickerUI(id: $0.id, name: $0.name, hasInstallments: $0.hasInstallments) }
                self?.paymentMethods.insert(.placeholder, at: .zero)
            }
            .store(in: &cancellables)
    }
    
    func addOperation() {
        state = .loading
        validInputs = false
        
        operationsUseCase
            .addOperation(title: name,
                          date: date,
                          value: value,
                          categoryId: category,
                          paymentMethodId: paymentMethod,
                          installments: installments)
            .receive(on: RunLoop.main)
            .sinkCompletion { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .finished
                case .failure(let error):
                    self?.setupErrorBanner(error: error)
                    self?.state = .failure
                }
            }
            .store(in: &cancellables)
    }
}
