//
//  OperationFormView.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

struct OperationFormView: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            DSColor.background.rawValue.edgesIgnoringSafeArea([.top, .bottom])
            VStack(spacing: DSSpace.smallL.rawValue) {
                InputTextField(
                    title: "Nome da Operação",
                    placeholder: "Nome da origem ou descrição curta",
                    text: $viewModel.name
                )
                HStack(spacing: DSSpace.smallL.rawValue) {
                    InputTextField(
                        title: "Data",
                        placeholder: "DD/MM/YYYY",
                        text: $viewModel.name
                    )
                    InputTextField(
                        title: "Valor",
                        placeholder: "R$ 0.000,00",
                        text: $viewModel.name
                    )
                }
            }
            .padding(24)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OperationFormView_Previews: PreviewProvider {
    static var previews: some View {
        OperationFormView(viewModel: .init())
    }
}
