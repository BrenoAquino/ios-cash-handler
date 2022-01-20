//
//  OperationFormViewModel.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI
import Domain

public extension OperationFormView {
    
    final class ViewModel: ObservableObject {
        
        let type: Domain.OperationType
        private let operationsUseCase: Domain.OperationsUseCase
        
        @Published var name: String = .empty
        @Published var date: String = .empty
        @Published var value: String = .empty
        @Published var category: String = .empty
        @Published var paymentType: String = .empty
        
        public init(operationsUseCase: Domain.OperationsUseCase, type: OperationType) {
            self.operationsUseCase = operationsUseCase
            self.type = type
        }
    }
}

extension OperationFormView.ViewModel {
    func addOperation() {
        operationsUseCase.addOperation(
            title: name,
            date: date,
            value: Double(value) ?? .zero,
            category: category,
            paymentType: paymentType,
            operationType: type
        )
    }
}
