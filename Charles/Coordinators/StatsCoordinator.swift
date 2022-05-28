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
        
        init(statsViewModel: StatsView.ViewModel) {
            self.statsViewModel = statsViewModel
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
    }
}
