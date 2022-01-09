//
//  HomeViewModel.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

extension HomeView {
    
    class ViewModel: ObservableObject {
        
        @Published var operationOptions: Bool = false
        
        
        // MARK: Actions
        func selectAdd() {
            operationOptions = true
        }
        
        func addCashIn() {
            operationOptions = false
            print("addCashIn")
        }
        
        func addCashOut() {
            operationOptions = false
            print("addCashOut")
        }
        
        func addCancel() {
            operationOptions = false
            print("addCancel")
        }
    }
}
