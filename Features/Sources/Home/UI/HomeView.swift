//
//  HomeView.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI
import DesignSystem

public struct HomeView: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        content
            .background(
                DSColor.background.rawValue.edgesIgnoringSafeArea(.all)
            )
            .confirmationDialog(Localizable.Home.operationOptionsTitle,
                                isPresented: $viewModel.operationOptions,
                                titleVisibility: .visible,
                                actions: {
                Button(Localizable.Home.cashInOption, action: viewModel.addCashIn)
                Button(Localizable.Home.cashOutOption, action: viewModel.addCashOut)
                Button(Localizable.Common.cancel, role: .cancel, action: viewModel.addCancel)
            })
            .toolbar {
                profileBar
                addBar
            }
    }
    
    // MARK: View State
    private var content: AnyView {
        switch viewModel.state {
        case .loading:
            return AnyView(ViewState.loadingView(background: .opaque))
        default:
            return AnyView(operationsList)
        }
    }
    
    // MARK: Navigation Bar
    private var profileBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            HStack(spacing: DSSpace.smallM.rawValue) {
                ZStack() {
                    Circle()
                        .fill(DSColor.secondBackground.rawValue)
                        .frame(width: DSHome.circleRadius, height: DSHome.circleRadius)
                        .shadow(style: .medium)
                    Text(Localizable.Home.userInitials)
                        .foregroundColor(DSColor.primaryText.rawValue)
                        .font(.headline)
                }
                Spacer(minLength: DSSpace.smallS.rawValue)
                VStack(alignment: .leading, spacing: DSSpace.smallS.rawValue) {
                    Text(Localizable.Home.userTitle)
                        .foregroundColor(DSColor.primaryText.rawValue)
                        .font(.headline)
                    Text(Localizable.Home.companyTitle)
                        .foregroundColor(DSColor.primaryText.rawValue)
                        .font(.subheadline)
                }
            }
        }
    }
    
    private var addBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: viewModel.selectAdd) {
                ImageAsset.add.tint(Color.white)
            }
        }
    }
    
    // MARK: Content List
    private var operationsList: some View {
        List(viewModel.operations) { operation in
            OperationCell(operation: operation)
        }
    }
}

#if DEBUG
// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView(viewModel: .init(categoriesUseCase: CategoriesUseCasePreview(),
                                      paymentMethods: PaymentMethodsUseCasePreview(),
                                      operationsUseCase: OperationsUseCasePreview()))
        }
    }
}
#endif
