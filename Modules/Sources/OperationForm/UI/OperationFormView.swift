//
//  OperationFormView.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI
import DesignSystem
import Common
import Domain

public struct OperationFormView: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            DSColor.background.rawValue.edgesIgnoringSafeArea([.top, .bottom])
            VStack(spacing: DSSpace.smallL.rawValue) {
                title
                form
                addButton
            }
            .padding(DSSpace.normal.rawValue)
        }
        .onTapGesture(perform: UIApplication.shared.endEditing)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Header
    private var title: some View {
        Text(Localizable.OperationForm.operationFormTitle)
            .font(DSFont.largeTitle.rawValue)
            .foregroundColor(DSColor.primaryText.rawValue)
            .padding()
    }
    
    // MARK: Form
    private var form: some View {
        Group {
            DSInputTextField(
                title: Localizable.OperationForm.operationTitle,
                placeholder: Localizable.OperationForm.operationPlaceholder,
                text: $viewModel.name
            )
            HStack(spacing: DSSpace.smallL.rawValue) {
                DSInputTextField(
                    title: Localizable.OperationForm.dateTitle,
                    placeholder: Localizable.OperationForm.datePlaceholder,
                    text: $viewModel.date
                )
                DSInputTextField(
                    title: Localizable.OperationForm.valueTitle,
                    placeholder: Localizable.OperationForm.valuePlaceholder,
                    text: $viewModel.value
                )
            }
            if viewModel.type == .cashOut {
                DSInputTextField(
                    title: Localizable.OperationForm.categoryTitle,
                    placeholder: Localizable.OperationForm.categoryPlaceholder,
                    text: $viewModel.category
                )
                DSInputTextField(
                    title: Localizable.OperationForm.paymentTypeTitle,
                    placeholder: Localizable.OperationForm.paymentPlaceholder,
                    text: $viewModel.paymentType
                )
            }
        }
    }
    
    // MARK: Button
    private var addButton: some View {
        Group {
            DSButton(title: Localizable.OperationForm.buttonTitle, action: viewModel.addOperation)
                .frame(maxWidth: .infinity, minHeight: DSOperationForm.buttonHeight)
                .background(DSColor.secondBackground.rawValue)
                .clipShape(RoundedRectangle(cornerRadius: DSCornerRadius.normal.rawValue))
                .shadow(style: .easy)
        }.padding()
    }
}

#if DEBUG
// MARK: - Preview
import Combine
import Domain

struct OperationFormView_Previews: PreviewProvider {
    
    private class UseCaseMock: OperationsUseCase {
        func addOperation(title: String,
                          date: String,
                          value: Double,
                          category: String,
                          paymentType: String,
                          operationType: OperationType) -> AnyPublisher<Domain.Operation, Error> {
            return Empty().eraseToAnyPublisher()
        }
    }
    
    static var previews: some View {
        let useCase = UseCaseMock()
        let viewModel = OperationFormView.ViewModel(operationsUseCase: useCase, type: .cashOut)
        OperationFormView(viewModel: viewModel)
    }
}
#endif
