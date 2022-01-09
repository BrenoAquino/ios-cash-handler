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
        var selectAddOperation: ((OperationFormView.OperationType) -> Void)?
        
        // MARK: Actions
        func selectAdd() {
            operationOptions = true
        }
        
        func addCashIn() {
            operationOptions = false
            selectAddOperation?(.cashIn)
        }
        
        func addCashOut() {
            operationOptions = false
            selectAddOperation?(.cashOut)
        }
        
        func addCancel() {
            operationOptions = false
        }
    }
}
