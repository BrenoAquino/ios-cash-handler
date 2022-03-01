//
//  HomeCoordinator.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI
import Home
import OperationForm

struct HomeCoordinator: View {
    
    class ViewModel: ObservableObject {
        let homeViewModel: HomeView.ViewModel
        
        // MARK: Destionations ViewModel
        @Published var operationFormViewModel: OperationFormCoordinator.ViewModel?
        
        init(homeViewModel: HomeView.ViewModel) {
            self.homeViewModel = homeViewModel
            self.homeViewModel.selectAddOperation = { [weak self] in
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
        HomeView(viewModel: viewModel.homeViewModel)
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
