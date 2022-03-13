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
        
        private let operationsUseCase: Domain.OperationsUseCase
        private let categoriesUseCase: Domain.CategoriesUseCase
        private let paymentMethodsUseCase: Domain.PaymentMethodsUseCase
        private var cancellables: Set<AnyCancellable> = .init()
        
        private(set) var categories: [CategoryPickerUI] = []
        private(set) var paymentMethods: [PaymentMethodPickerUI] = []
        
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
        
        @Published private(set) var hasInstallments: Bool = false
        @Published private(set) var isValidCategory: Bool = false
        @Published private(set) var isValidPaymentMethod: Bool = false
        @Published private(set) var validInputs: Bool = false
        @Published private(set) var stateHandler: ViewStateHandler = .init(state: .content)
        
        // MARK: Inits
        public init(operationsUseCase: Domain.OperationsUseCase,
                    categoriesUseCase: Domain.CategoriesUseCase,
                    paymentMethodsUseCase: Domain.PaymentMethodsUseCase) {
            self.operationsUseCase = operationsUseCase
            self.categoriesUseCase = categoriesUseCase
            self.paymentMethodsUseCase = paymentMethodsUseCase
            
            setupCategories()
            setupPaymentMethods()
            checkInputsSubscribers()
        }
    }
}

// MARK: - Setups
extension OperationFormView.ViewModel {
    private func setupCategories() {
        categories = [.placeholder]
        categories.append(contentsOf: categoriesUseCase.cachedCategories().map {
            CategoryPickerUI(id: $0.id, name: $0.name)
        })
    }
    
    private func setupPaymentMethods() {
        paymentMethods = [.placeholder]
        paymentMethods.append(contentsOf: paymentMethodsUseCase.cachedPaymentMethods().map {
            PaymentMethodPickerUI(id: $0.id, name: $0.name, hasInstallments: $0.hasInstallments)
        })
    }
    
    private func setupErrorBanner(error: CharlesError) {
        banner.data = .init(title: Localizable.Common.failureTitleBanner,
                            subtitle: error.localizedDescription,
                            type: .failure)
        banner.show = true
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
    func checkInputsSubscribers() {
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
    
    func addOperation() {
        stateHandler.loading()
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
                    self?.stateHandler.finished()
                case .failure(let error):
                    self?.setupErrorBanner(error: error)
                    self?.stateHandler.failure()
                }
            }
            .store(in: &cancellables)
    }
}
