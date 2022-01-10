//
//  OperationFormViewModel.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

extension OperationFormView {
    
    enum OperationType {
        case cashIn
        case cashOut
    }
    
    class ViewModel: ObservableObject {
        
        let type: OperationType
        
        @Published var name: String = .empty
        @Published var date: String = .empty
        @Published var value: String = .empty
        @Published var category: String = .empty
        @Published var paymentType: String = .empty
        
        init(type: OperationType) {
            self.type = type
        }
        
        func addOperation() {
            print(name, date, value)
        }
    }
}
