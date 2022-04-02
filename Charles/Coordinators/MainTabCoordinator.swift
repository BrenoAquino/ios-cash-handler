//
//  MainTabCoordinator.swift
//  Charles
//
//  Created by Breno Aquino on 11/03/22.
//

import SwiftUI
import MainTab

struct MainTabCoordinator: View {
    
    class ViewModel: ObservableObject {
        let mainTabViewModel: MainTabViewModel
        
        init(mainTabViewModel: MainTabViewModel) {
            self.mainTabViewModel = mainTabViewModel
        }
    }
    
    // MARK: Coordinator
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Self View
    var body: some View {
        MainTabView(viewModel: viewModel.mainTabViewModel) {
            NavigationView {
                OverviewCoordinator(viewModel: ViewModelFactory.coordinatorOverview())
            }
            .tabItem {
                Label("Overview", systemImage: "chart.bar.fill")
            }
            
            NavigationView {
                StatementCoordinator(viewModel: ViewModelFactory.coordinatorStatement())
            }
            .tabItem {
                Label("Extrato", systemImage: "list.triangle")
            }
        }
    }
}
