//
//  HomeCoordinator.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI
import Statement
import OperationForm

struct StatementCoordinator: View {
    
    class ViewModel: ObservableObject {
        let statementViewModel: StatementView.ViewModel
        
        // MARK: Destionations ViewModel
        @Published var operationFormViewModel: OperationFormCoordinator.ViewModel?
        
        init(statementViewModel: StatementView.ViewModel) {
            self.statementViewModel = statementViewModel
            self.statementViewModel.selectAddOperation = { [weak self] in
                self?.operationFormViewModel = ViewModelFactory.coordinatorOperationForm()
            }
        }
    }
    
    // MARK: Coordinator
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Self View
    var body: some View {
        StatementView(viewModel: viewModel.statementViewModel)
            .overlay(operationFormLink)
    }
    
    // MARK: Navigations Links
    var operationFormLink: some View {
        NavigationLink(
            destination: viewModel.operationFormViewModel.map(OperationFormCoordinator.init),
            isActive: .init(
                get: { viewModel.operationFormViewModel != nil },
                set: { if !$0 { viewModel.operationFormViewModel = nil } }
            ),
            label: EmptyView.init
        )
    }
}
