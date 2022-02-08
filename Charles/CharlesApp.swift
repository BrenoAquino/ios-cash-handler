//
//  CharlesApp.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

@main
struct CharlesApp: App {
    
    init() {
        setupTableViewAppearance()
    }
    
    // MARK: Setups
    func setupTableViewAppearance() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    // MARK: Scene
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeCoordinator(viewModel: .init(homeViewModel: .init()))
            }
            .navigationViewStyle(.automatic)
//            .navigationViewStyle(.stack)
            .preferredColorScheme(.dark)
        }
    }
}
