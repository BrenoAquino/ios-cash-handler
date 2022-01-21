//
//  OperationFormCoordinator.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI
import OperationForm

struct OperationFormCoordinator: View {
    
    class ViewModel: ObservableObject {
        let operationFormViewModel: OperationFormView.ViewModel
        
        init(operationFormViewModel: OperationFormView.ViewModel) {
            self.operationFormViewModel = operationFormViewModel
        }
    }
    
    // MARK: Coordinator
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Self View
    var body: some View {
        OperationFormView(viewModel: viewModel.operationFormViewModel)
    }
}
