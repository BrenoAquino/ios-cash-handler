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
            .overlay { overlayState }
            .navigationTitle(Localizable.OperationForm.operationFormTitle)
            .background(DSColor.background.rawValue.edgesIgnoringSafeArea(.all))
            .banner(data: $viewModel.banner.data, show: $viewModel.banner.show)
            .toolbar {
                hideKeyboardBar
                doneBar
            }
            .onReceive(viewModel.$stateHandler) { stateHandler in
                if stateHandler.state == .finished {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
    }
    
    // MARK: View State
    private var overlayState: some View {
        ZStack {
            switch viewModel.stateHandler.state {
            case .loading:
                ViewState.loadingView(background: .blur).defaultTransition()
            default:
                EmptyView().defaultTransition()
            }
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
            title
            value
            category
            payment
            date
        }
    }
    
    private var title: some View {
        Section(Localizable.OperationForm.operationTitle) {
            TextField(Localizable.OperationForm.operationPlaceholder,
                      text: $viewModel.name)
                .listRowBackground(DSColor.secondBackground.rawValue)
        }
    }
    
    private var value: some View {
        Section(Localizable.OperationForm.valueTitle) {
            CurrencyTextField(value: $viewModel.value)
                .listRowBackground(DSColor.secondBackground.rawValue)
        }
    }
    
    private var category: some View {
        Section(Localizable.OperationForm.categoryTitle) {
            Picker(Localizable.OperationForm.categoryPlaceholder, selection: $viewModel.category) {
                ForEach(viewModel.categories) {
                    Text($0.name)
                }
            }
            .accentColor(
                viewModel.isValidCategory ?
                    DSColor.primaryText.rawValue :
                    DSColor.placholder.rawValue
            )
            .pickerStyle(.menu)
            .listRowBackground(DSColor.secondBackground.rawValue)
        }
    }
    
    private var payment: some View {
        Section(Localizable.OperationForm.paymentTypeTitle) {
            HStack {
                Picker(Localizable.OperationForm.paymentPlaceholder, selection: $viewModel.paymentMethod) {
                    ForEach(viewModel.paymentMethods) {
                        Text($0.name)
                    }
                }
                .accentColor(
                    viewModel.isValidPaymentMethod ?
                        DSColor.primaryText.rawValue :
                        DSColor.placholder.rawValue
                )
                .pickerStyle(.menu)
                
                if viewModel.hasInstallments {
                    TextField("x12", text: $viewModel.installments)
                }
            }
            .listRowBackground(DSColor.secondBackground.rawValue)
        }
    }
    
    private var date: some View {
        Section(Localizable.OperationForm.dateTitle) {
            DatePicker(String.empty, selection: $viewModel.date, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
                .listRowBackground(DSColor.secondBackground.rawValue)
        }
    }
}

#if DEBUG
// MARK: - Preview
struct OperationFormView_Previews: PreviewProvider {
    
    static var previews: some View {
        UITableView.appearance().backgroundColor = .clear
        
        let viewModel = OperationFormView.ViewModel(
            operationsUseCase: OperationsUseCaseMock()
        )
        
        return NavigationView {
            OperationFormView(viewModel: viewModel)
        }
        .preferredColorScheme(.dark)
    }
}
#endif
