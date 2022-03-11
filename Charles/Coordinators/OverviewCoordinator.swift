//
//  OverviewCoordinator.swift
//  Charles
//
//  Created by Breno Aquino on 10/03/22.
//

import SwiftUI
import Overview

struct OverviewCoordinator: View {
    
    class ViewModel: ObservableObject {
        let overviewViewModel: OverviewView.ViewModel
        
        init(overviewViewModel: OverviewView.ViewModel) {
            self.overviewViewModel = overviewViewModel
        }
    }
    
    // MARK: Coordinator
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Self View
    var body: some View {
        OverviewView(viewModel: viewModel.overviewViewModel)
    }
}
