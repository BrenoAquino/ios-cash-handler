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
        
        @Published var name: String = .empty
        @Published var date: Date = .init()
        @Published var value: String = .empty
        @Published var category: String = .empty
        @Published var paymentType: String = .empty
        @Published private(set) var validInputs: Bool = false
        @Published private(set) var state: ViewState = .content
        
        public init(operationsUseCase: Domain.OperationsUseCase, type: OperationType) {
            self.operationsUseCase = operationsUseCase
            self.type = type
            
            checkInputsSubscribers()
        }
    }
}

extension OperationFormView.ViewModel {
    
    func checkInputsSubscribers() {
        let inputValidator: () -> Bool = { [weak self] in
            guard let self = self else { return false }
            return !self.name.isEmpty && !self.value.isEmpty && !self.category.isEmpty && !self.paymentType.isEmpty
        }
        
        $name.sink(receiveValue: { [weak self] _ in self?.validInputs = inputValidator() }).store(in: &cancellables)
        $value.sink(receiveValue: { [weak self] _ in self?.validInputs = inputValidator() }).store(in: &cancellables)
        $category.sink(receiveValue: { [weak self] _ in self?.validInputs = inputValidator() }).store(in: &cancellables)
        $paymentType.sink(receiveValue: { [weak self] _ in self?.validInputs = inputValidator() }).store(in: &cancellables)
    }
    
    func addOperation() {
        state = .loading
        operationsUseCase
            .addOperation(title: name,
                          date: Date(),
                          value: value,
                          category: category,
                          paymentType: paymentType,
                          operationType: type)
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
