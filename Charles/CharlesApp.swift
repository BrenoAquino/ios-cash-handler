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
        setupScrollViewAppearance()
    }
    
    // MARK: Setups
    func setupTableViewAppearance() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    func setupScrollViewAppearance() {
        UIScrollView.appearance().showsVerticalScrollIndicator = false
        UIScrollView.appearance().showsHorizontalScrollIndicator = false
        UIScrollView.appearance().keyboardDismissMode = .onDrag
    }
    
    // MARK: Scene
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeCoordinator(viewModel: ViewModelFactory.coordinatorHome())
            }
            .navigationViewStyle(.automatic)
            .preferredColorScheme(.dark)
        }
    }
}
