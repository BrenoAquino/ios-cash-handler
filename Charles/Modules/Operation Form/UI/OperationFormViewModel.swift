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
        
        @Published var name: String = ""
        @Published var date: String = ""
        @Published var value: String = ""
        
        init(type: OperationType) {
            self.type = type
        }
        
        func addOperation() {
            
        }
    }
}
