//
//  OperationFormView.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

struct OperationFormView: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    init(viewModel: ViewModel = ViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: DSSpace.smallL.rawValue) {
            InputTextField(
                title: "Nome da Operação",
                placeholder: "Nome da origem ou descrição curta",
                text: $viewModel.name
            ).frame(height: 56)
            HStack(spacing: DSSpace.smallL.rawValue) {
                InputTextField(
                    title: "Data",
                    placeholder: "DD/MM/YYYY",
                    text: $viewModel.name
                ).frame(height: 56)
                InputTextField(
                    title: "Valor",
                    placeholder: "R$ 0.000,00",
                    text: $viewModel.name
                ).frame(height: 56)
            }
        }
        .padding(24)
    }
}

struct OperationFormView_Previews: PreviewProvider {
    static var previews: some View {
        OperationFormView()
    }
}
