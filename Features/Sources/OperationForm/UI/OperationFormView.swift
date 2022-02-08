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
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private(set) var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        form
            .navigationTitle(Localizable.OperationForm.operationFormTitle)
            .onTapGesture(perform: UIApplication.shared.endEditing)
            .onReceive(viewModel.$state) { state in
                if state == .finished {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .background(
                DSColor.background.rawValue.edgesIgnoringSafeArea(.all)
            )
            .toolbar {
                doneBar
            }
    }
    
    // MARK: Form
    private var form: some View {
        Form {
            Section(Localizable.OperationForm.operationTitle) {
                TextField(Localizable.OperationForm.operationPlaceholder,
                          text: $viewModel.name)
                    .listRowBackground(DSColor.secondBackground.rawValue)
            }
            Section(Localizable.OperationForm.valueTitle) {
                TextField(Localizable.OperationForm.valuePlaceholder,
                          text: $viewModel.value)
                    .keyboardType(.numberPad)
                    .listRowBackground(DSColor.secondBackground.rawValue)
            }
            Section(Localizable.OperationForm.categoryTitle) {
                TextField(Localizable.OperationForm.categoryPlaceholder,
                          text: $viewModel.category)
                    .listRowBackground(DSColor.secondBackground.rawValue)
            }
            Section(Localizable.OperationForm.paymentTypeTitle) {
                TextField(Localizable.OperationForm.paymentPlaceholder,
                          text: $viewModel.paymentType)
                    .listRowBackground(DSColor.secondBackground.rawValue)
            }
            Section(Localizable.OperationForm.dateTitle) {
                DatePicker("", selection: $viewModel.date, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
                    .listRowBackground(DSColor.secondBackground.rawValue)
            }
        }
    }
    
    // MARK: ToolBar
    private var doneBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: viewModel.addOperation) {
                ImageAsset.done.tint(Color.white)
            }
        }
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
                          operationType: OperationType) -> AnyPublisher<Domain.Operation, Domain.CharlesError> {
            return Empty().eraseToAnyPublisher()
        }
    }
    
    static var previews: some View {
        UITableView.appearance().backgroundColor = .clear
        let useCase = UseCaseMock()
        let viewModel = OperationFormView.ViewModel(operationsUseCase: useCase, type: .cashOut)
        
        return NavigationView {
            OperationFormView(viewModel: viewModel)
        }
        .preferredColorScheme(.dark)
    }
}
#endif
