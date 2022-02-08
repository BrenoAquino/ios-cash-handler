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
        Group {
            content
        }
        .navigationTitle(Localizable.OperationForm.operationFormTitle)
        .background(
            DSColor.background.rawValue.edgesIgnoringSafeArea(.all)
        )
        .toolbar {
            hideKeyboardBar
            doneBar
        }
        .onReceive(viewModel.$state) { state in
            if state == .finished {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    // MARK: View State
    private var content: AnyView {
        switch viewModel.state {
        case .loading:
            return AnyView(ZStack {
                form
                ViewState.loadingView
            })
            
        default:
            return AnyView(form)
        }
    }
    
    // MARK: ToolBar
    private var hideKeyboardBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: UIApplication.shared.endEditing) {
                ImageAsset.hideKeyboard.tint(DSColor.primaryText.rawValue)
            }
        }
    }
    
    private var doneBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: viewModel.addOperation) {
                ImageAsset.done.tint(DSColor.primaryText.rawValue)
            }
            .disabled(!viewModel.validInputs)
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
                DatePicker(String.empty, selection: $viewModel.date, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
                    .listRowBackground(DSColor.secondBackground.rawValue)
            }
        }
    }
}

#if DEBUG
// MARK: - Preview
struct OperationFormView_Previews: PreviewProvider {
    
    static var previews: some View {
        UITableView.appearance().backgroundColor = .clear
        
        let viewModel = OperationFormView.ViewModel(
            operationsUseCase: OperationsUseCaseMock(),
            type: .cashOut
        )
        
        return NavigationView {
            OperationFormView(viewModel: viewModel)
        }
        .preferredColorScheme(.dark)
    }
}
#endif
