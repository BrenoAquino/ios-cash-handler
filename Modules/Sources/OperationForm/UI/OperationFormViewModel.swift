//
//  OperationFormViewModel.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI
import Domain
import DesignSystem
import Combine

public extension OperationFormView {
    
    final class ViewModel: ObservableObject {
        
        let type: Domain.OperationType
        private let operationsUseCase: Domain.OperationsUseCase
        private var cancellables: Set<AnyCancellable> = .init()
        
        @Published var name: String = .empty
        @Published var date: String = .empty
        @Published var value: String = .empty
        @Published var category: String = .empty
        @Published var paymentType: String = .empty
        @Published var state: ViewState = .content
        
        public init(operationsUseCase: Domain.OperationsUseCase, type: OperationType) {
            self.operationsUseCase = operationsUseCase
            self.type = type
        }
    }
}

extension OperationFormView.ViewModel {
    func addOperation() {
        state = .loading
        operationsUseCase
            .addOperation(title: name,
                          date: date,
                          value: Double(value) ?? .zero,
                          category: category,
                          paymentType: paymentType,
                          operationType: type)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .finished
                case .failure:
                    self?.state = .failure
                }
            }, receiveValue: {_ in })
            .store(in: &cancellables)
    }
}
