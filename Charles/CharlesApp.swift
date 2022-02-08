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
        setupNavigationBar()
        setupDatePicker()
    }
    
    // MARK: Setups
    private func setupNavigationBar() {
        UINavigationBar.appearance().tintColor = .white
    }
    
    private func setupDatePicker() {
        UIDatePicker.appearance().backgroundColor = UIColor.init(.white)
        UIDatePicker.appearance().tintColor = UIColor.init(.white)
    }
    
    // MARK: Scene
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeCoordinator(viewModel: .init(homeViewModel: .init()))
            }
            .navigationViewStyle(.stack)
        }
    }
}
