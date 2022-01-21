//
//  ViewModelFactory.swift
//  Charles
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import OperationForm
import Domain

enum ViewModelFactory {
    
    static func operationForm(type: OperationType) -> OperationFormView.ViewModel {
        let useCase = UseCaseFactory.operations()
        return OperationFormView.ViewModel(operationsUseCase: useCase, type: type)
    }
    
    static func coordinatorOperationForm(type: OperationType) -> OperationFormCoordinator.ViewModel {
        let viewModel = Self.operationForm(type: type)
        return OperationFormCoordinator.ViewModel(operationFormViewModel: viewModel)
    }
}
