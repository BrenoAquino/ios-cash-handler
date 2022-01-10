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
                title
                form
                addButton
            }
            .padding(DSSpace.normal.rawValue)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Header
    private var title: some View {
        Text("Operation")
            .font(DSFont.largeTitle.rawValue)
            .foregroundColor(DSColor.primaryText.rawValue)
            .padding()
    }
    
    // MARK: Form
    private var form: some View {
        Group {
            DSInputTextField(
                title: "Nome da Operação",
                placeholder: "Nome da origem ou descrição curta",
                text: $viewModel.name
            )
            HStack(spacing: DSSpace.smallL.rawValue) {
                DSInputTextField(
                    title: "Data",
                    placeholder: "DD/MM/YYYY",
                    text: $viewModel.date
                )
                DSInputTextField(
                    title: "Valor",
                    placeholder: "R$ 0.000,00",
                    text: $viewModel.value
                )
            }
            if viewModel.type == .cashOut {
                DSInputTextField(
                    title: "Categoria",
                    placeholder: "Ex: Refeição",
                    text: $viewModel.name
                )
                DSInputTextField(
                    title: "Meio de transação",
                    placeholder: "Ex: Cartão de Crédito",
                    text: $viewModel.name
                )
            }
        }
    }
    
    // MARK: Button
    private var addButton: some View {
        Group {
            DSButton(title: "Add Operation", action: viewModel.addOperation)
                .frame(maxWidth: .infinity, minHeight: 56)
                .background(DSColor.secondBackground.rawValue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(style: .easy)
        }.padding()
    }
}

struct OperationFormView_Previews: PreviewProvider {
    static var previews: some View {
        OperationFormView(viewModel: .init(type: .cashOut))
    }
}
