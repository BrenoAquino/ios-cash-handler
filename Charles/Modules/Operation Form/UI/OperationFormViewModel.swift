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
        
        @Published var name: String = ""
    }
}
