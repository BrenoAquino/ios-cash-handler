//
//  ViewModelFactory.swift
//  Charles
//
//  Created by Breno Aquino on 20/01/22.
//

import Foundation
import Overview
import Home
import OperationForm

enum ViewModelFactory {
    
    static func overview() -> OverviewView.ViewModel {
        return OverviewView.ViewModel()
    }
    
    static func coordinatorOverview() -> OverviewCoordinator.ViewModel {
        return OverviewCoordinator.ViewModel(overviewViewModel: Self.overview())
    }
    
    static func home() -> HomeView.ViewModel {
        return HomeView.ViewModel(categoriesUseCase: UseCaseFactory.categories(),
                                  paymentMethods: UseCaseFactory.paymentMethods(),
                                  operationsUseCase: UseCaseFactory.operations())
    }
    
    static func coordinatorHome() -> HomeCoordinator.ViewModel {
        return HomeCoordinator.ViewModel(homeViewModel: Self.home())
    }
    
    static func operationForm() -> OperationFormView.ViewModel {
        return OperationFormView.ViewModel(operationsUseCase: UseCaseFactory.operations())
    }
    
    static func coordinatorOperationForm() -> OperationFormCoordinator.ViewModel {
        return OperationFormCoordinator.ViewModel(operationFormViewModel: Self.operationForm())
    }
}
