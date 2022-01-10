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
        UINavigationBar.appearance().tintColor = .white
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeCoordinator(viewModel: .init(homeViewModel: .init()))
            }
            .navigationViewStyle(.stack)
        }
    }
}
