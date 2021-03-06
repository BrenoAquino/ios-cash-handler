//
//  StatsCoordinator.swift
//  Charles
//
//  Created by Breno Aquino on 10/03/22.
//

import SwiftUI
import Stats

struct StatsCoordinator: View {
    
    class ViewModel: ObservableObject {
        let statsViewModel: StatsView.ViewModel
        
        // MARK: Destionations ViewModel
        @Published var operationFormViewModel: OperationFormCoordinator.ViewModel?
        
        init(statsViewModel: StatsView.ViewModel) {
            self.statsViewModel = statsViewModel
            self.statsViewModel.selectAddOperation = { [weak self] in
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
        StatsView(viewModel: viewModel.statsViewModel)
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
