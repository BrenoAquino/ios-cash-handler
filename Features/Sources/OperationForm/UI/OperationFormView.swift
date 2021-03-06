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
            .onAppear(perform: viewModel.initialData)
            .onReceive(viewModel.$state) { state in
                if state == .finished {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
    }
    
    // MARK: View State
    private var overlayState: some View {
        ZStack {
            switch viewModel.state {
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
        ScrollView {
            title
            value
            category
            payment
            date
        }
    }
    
    private var title: some View {
        LabeledField(Localizable.OperationForm.operationTitle) {
            TextField(Localizable.OperationForm.operationPlaceholder, text: $viewModel.name)
        }
        .padding(DSSpace.smallL.rawValue)
    }
    
    private var value: some View {
        LabeledField(Localizable.OperationForm.valueTitle) {
            CurrencyTextField(value: $viewModel.value)
        }
        .padding(.horizontal, DSSpace.smallL.rawValue)
        .padding(.bottom, DSSpace.smallL.rawValue)
    }
    
    private var category: some View {
        LabeledField(Localizable.OperationForm.categoryTitle) {
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
        }
        .padding(.horizontal, DSSpace.smallL.rawValue)
        .padding(.bottom, DSSpace.smallL.rawValue)
    }
    
    private var payment: some View {
        HStack {
            LabeledField(Localizable.OperationForm.paymentTypeTitle) {
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
            }
            
            if viewModel.hasInstallments {
                LabeledField(Localizable.OperationForm.installmentsTypeTitle) {
                    MaskedTextField(placeholder: Localizable.OperationForm.installmentsPlaceholder,
                                    keyboardType: .numberPad,
                                    textAlignment: .center,
                                    formatter: viewModel.installmentsFormatter,
                                    text: $viewModel.installments)
                }
                .frame(width: DSOperationForm.installmentsWidth)
            }
        }
        .animation(.linear, value: viewModel.hasInstallments)
        .padding(.horizontal, DSSpace.smallL.rawValue)
        .padding(.bottom, DSSpace.smallL.rawValue)
    }
    
    private var date: some View {
        LabeledField(Localizable.OperationForm.dateTitle) {
            DatePicker(String.empty,
                       selection: $viewModel.date,
                       in: ...Date(),
                       displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
                .listRowBackground(DSColor.secondBackground.rawValue)
        }
        .padding(.horizontal, DSSpace.smallL.rawValue)
        .padding(.bottom, DSSpace.smallL.rawValue)
    }
}

#if DEBUG
// MARK: - Preview
import Previews

struct OperationFormView_Previews: PreviewProvider {
    
    static var previews: some View {
        UITableView.appearance().backgroundColor = .clear
        
        let viewModel = OperationFormView.ViewModel(
            operationsUseCase: OperationsUseCasePreview(),
            categoriesUseCase: CategoriesUseCasePreview(),
            paymentMethodsUseCase: PaymentMethodsUseCasePreview()
        )
        
        return NavigationView {
            OperationFormView(viewModel: viewModel)
        }
        .preferredColorScheme(.dark)
    }
}
#endif
