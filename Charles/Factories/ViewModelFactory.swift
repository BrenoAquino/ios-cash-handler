//
//  ViewModelFactory.swift
//  Charles
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Overview
import Statement
import OperationForm
import MainTab

enum ViewModelFactory {
    
    // MARK: Main Tab
    static func mainTab() -> MainTabViewModel {
        return MainTabViewModel(categoriesUseCase: UseCaseFactory.categories(),
                                paymentMethods: UseCaseFactory.paymentMethods())
    }
    
    static func coordinatorMainTab() -> MainTabCoordinator.ViewModel {
        return MainTabCoordinator.ViewModel(mainTabViewModel: ViewModelFactory.mainTab())
    }
    
    // MARK: Overview
    static func overview() -> OverviewView.ViewModel {
        return OverviewView.ViewModel(operationsUseCase: UseCaseFactory.operations())
    }
    
    static func coordinatorOverview() -> OverviewCoordinator.ViewModel {
        return OverviewCoordinator.ViewModel(overviewViewModel: Self.overview())
    }
    
    // MARK: Statement
    static func statement() -> StatementView.ViewModel {
        return StatementView.ViewModel(operationsUseCase: UseCaseFactory.operations())
    }
    
    static func coordinatorStatement() -> StatementCoordinator.ViewModel {
        return StatementCoordinator.ViewModel(statementViewModel: Self.statement())
    }
    
    // MARK: Operation Form
    static func operationForm() -> OperationFormView.ViewModel {
        return OperationFormView.ViewModel(operationsUseCase: UseCaseFactory.operations(),
                                           categoriesUseCase: UseCaseFactory.categories(),
                                           paymentMethodsUseCase: UseCaseFactory.paymentMethods())
    }
    
    static func coordinatorOperationForm() -> OperationFormCoordinator.ViewModel {
        return OperationFormCoordinator.ViewModel(operationFormViewModel: Self.operationForm())
    }
}
