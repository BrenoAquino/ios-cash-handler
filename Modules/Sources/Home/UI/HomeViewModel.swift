//
//  HomeViewModel.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import Foundation

public extension HomeView {
    
    final class ViewModel: ObservableObject {
        
        @Published var operationOptions: Bool = false
        @Published var operations: [String] = []
        
        public var selectAddOperation: (() -> Void)?
        
        public init() {}
        
        // MARK: Actions
        func selectAdd() {
            operationOptions = true
        }
        
        func addCashIn() {
            operationOptions = false
            selectAddOperation?()
        }
        
        func addCashOut() {
            operationOptions = false
            selectAddOperation?()
        }
        
        func addCancel() {
            operationOptions = false
        }
    }
}
