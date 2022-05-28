//
//  ViewModelFactory.swift
//  Charles
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Stats
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
    static func stats() -> StatsView.ViewModel {
        return StatsView.ViewModel(statsUseCase: UseCaseFactory.stats())
    }
    
    static func coordinatorStats() -> StatsCoordinator.ViewModel {
        return StatsCoordinator.ViewModel(statsViewModel: Self.stats())
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
