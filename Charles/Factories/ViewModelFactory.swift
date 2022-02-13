//
//  ViewModelFactory.swift
//  Charles
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import OperationForm
import Domain
import Home

enum ViewModelFactory {
    
    static func home() -> HomeView.ViewModel {
        return HomeView.ViewModel(categoriesUseCase: UseCaseFactory.categories(),
                                  paymentMethods: UseCaseFactory.paymentMethods())
    }
    
    static func coordinatorHome() -> HomeCoordinator.ViewModel {
        let viewModel = Self.home()
        return HomeCoordinator.ViewModel(homeViewModel: viewModel)
    }
    
    static func operationForm(type: OperationType) -> OperationFormView.ViewModel {
        let useCase = UseCaseFactory.operations()
        return OperationFormView.ViewModel(operationsUseCase: useCase, type: type)
    }
    
    static func coordinatorOperationForm(type: OperationType) -> OperationFormCoordinator.ViewModel {
        let viewModel = Self.operationForm(type: type)
        return OperationFormCoordinator.ViewModel(operationFormViewModel: viewModel)
    }
}
