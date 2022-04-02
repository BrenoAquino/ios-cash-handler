//
//  ContentView.swift
//  Charles
//
//  Created by Breno Aquino on 10/03/22.
//

import SwiftUI
import Home

struct ContentView: View {
    
    var body: some View {
        TabView {
            OverviewCoordinator(viewModel: ViewModelFactory.coordinatorOverview())
                .tabItem {
                    Label("Overview", systemImage: "chart.bar.fill")
                }
            
            HomeCoordinator(viewModel: ViewModelFactory.coordinatorHome())
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
        }
    }
}

#if DEBUG
// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView()
            .preferredColorScheme(.dark)
    }
}
#endif
