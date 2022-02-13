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
        
        let type: Domain.OperationType
        private let operationsUseCase: Domain.OperationsUseCase
        private var cancellables: Set<AnyCancellable> = .init()
        
        var categories: [CategoryPickerUI] = []
        var paymentMethods: [PaymentMethodPickerUI] = []
        
        @Published var name: String = .empty
        @Published var date: Date = .init()
        @Published var value: String = .empty
        @Published var category: CategoryPickerUI = .placeholder
        @Published var paymentMethod: PaymentMethodPickerUI = .placeholder
        
        @Published private(set) var isValidCategory: Bool = false
        @Published private(set) var isValidPaymentMethod: Bool = false
        @Published private(set) var validInputs: Bool = false
        @Published private(set) var state: ViewState = .content
        
        public init(operationsUseCase: Domain.OperationsUseCase, type: OperationType) {
            self.operationsUseCase = operationsUseCase
            self.type = type
            
            setupCategories()
            setupPaymentMethods()
            checkInputsSubscribers()
        }
        
        private func setupCategories() {
            categories = [.placeholder]
            categories.append(contentsOf: operationsUseCase.categories().map {
                CategoryPickerUI(id: $0.id, name: $0.name)
            })
        }
        
        private func setupPaymentMethods() {
            paymentMethods = [.placeholder]
            paymentMethods.append(contentsOf: operationsUseCase.paymentMethods().map {
                PaymentMethodPickerUI(id: $0.id, name: $0.name)
            })
        }
    }
}

extension OperationFormView.ViewModel {
    
    func checkInputsSubscribers() {
        let inputValidator: () -> Bool = { [weak self] in
            guard let self = self else { return false }
            return !self.name.isEmpty && !self.value.isEmpty && self.isValidCategory && self.isValidPaymentMethod
        }
        
        $name.sink(receiveValue: { [weak self] _ in self?.validInputs = inputValidator() }).store(in: &cancellables)
        $value.sink(receiveValue: { [weak self] _ in self?.validInputs = inputValidator() }).store(in: &cancellables)
        
        $category
            .sink { [weak self] value in
                self?.isValidCategory = value.id != CategoryPickerUI.placeholder.id
                self?.validInputs = inputValidator()
            }
            .store(in: &cancellables)
        
        $paymentMethod
            .sink { [weak self] value in
                self?.isValidPaymentMethod = value.id != PaymentMethodPickerUI.placeholder.id
                self?.validInputs = inputValidator()
            }
            .store(in: &cancellables)
    }
    
    func addOperation() {
        state = .loading
        validInputs = false
        
        operationsUseCase
            .addOperation(title: name,
                          date: Date(),
                          value: value,
                          categoryId: category.id,
                          paymentMethodId: paymentMethod.id)
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
}
