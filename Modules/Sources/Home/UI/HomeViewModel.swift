//
//  HomeViewModel.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI
import Core

public extension HomeView {
    
    final class ViewModel: ObservableObject {
        
        @Published var operationOptions: Bool = false
        @Published var operations: [Core.Operation] = []
        
        public var selectAddOperation: ((Core.OperationType) -> Void)?
        
        public init() {}
        
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
