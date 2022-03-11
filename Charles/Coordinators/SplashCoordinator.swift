//
//  SplashCoordinator.swift
//  Charles
//
//  Created by Breno Aquino on 11/03/22.
//

import SwiftUI
import Splash

struct SplashCoordinator: View {
    
    class ViewModel: ObservableObject {
        let splashViewModel: SplashView.ViewModel
        
        init(splashViewModel: SplashView.ViewModel) {
            self.splashViewModel = splashViewModel
        }
    }
    
    // MARK: Coordinator
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Self View
    var body: some View {
        SplashView(viewModel: viewModel.splashViewModel)
    }
}
