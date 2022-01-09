//
//  OperationFormCoordinator.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

struct OperationFormCoordinator: View {
    
    class ViewModel: ObservableObject {
        let operationFormViewModel: OperationFormView.ViewModel
        
        init(operationFormViewModel: OperationFormView.ViewModel) {
            self.operationFormViewModel = operationFormViewModel
        }
    }
    
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        OperationFormView(viewModel: viewModel.operationFormViewModel)
    }
}
