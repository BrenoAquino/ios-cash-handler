//
//  HomeViewModel.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import Foundation
import Domain

public extension HomeView {
    
    final class ViewModel: ObservableObject {
        
        @Published var operationOptions: Bool = false
        @Published var operations: [String] = ["Breno", "Pinheiro", "Aquino"]
        
        public var selectAddOperation: ((Domain.OperationType) -> Void)?
        
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
