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
            .navigationTitle(Localizable.Home.homeTitle)
            .banner(data: $viewModel.banner.data, show: $viewModel.banner.show)
            .toolbar {
                addBar
            }
            .onAppear(perform: viewModel.fetchDate)
    }
    
    // MARK: View State
    private var content: some View {
         ZStack {
             switch viewModel.stateHandler.state {
             case .loading:
                 ViewState.loadingView(background: .opaque)
                     .defaultTransition()
             default:
                 operationsList
                     .defaultTransition()
             }
         }
     }
    
    // MARK: Navigation Bar
    private var addBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: viewModel.selectAdd) {
                ImageAsset.add.tint(Color.white)
            }
        }
    }
    
    // MARK: Content List
    private var operationsList: some View {
        List {
            ForEach(Array(viewModel.operations)) { aggregator in
                Section {
                    ForEach(aggregator.operations) { operation in
                        OperationCell(operation: operation)
                            .listRowSeparator(.hidden)
                            .listRowBackground(DSColor.clear.rawValue)
                            .listRowInsets(.init(top: DSSpace.smallM.rawValue,
                                                 leading: .zero,
                                                 bottom: DSSpace.smallM.rawValue,
                                                 trailing: .zero))
                    }
                    
                } header: {
                    HStack {
                        Text(aggregator.month)
                            .foregroundColor(DSColor.primaryText.rawValue)
                            .font(DSFont.headline2.rawValue)
                        
                        Text(aggregator.year)
                            .foregroundColor(DSColor.primaryText.rawValue)
                            .font(DSFont.footnote.rawValue)
                    }
                }
            }
        }
    }
}

#if DEBUG
// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        
        return NavigationView {
            HomeView(viewModel: .init(categoriesUseCase: CategoriesUseCasePreview(),
                                      paymentMethods: PaymentMethodsUseCasePreview(),
                                      operationsUseCase: OperationsUseCasePreview()))
        }
        .preferredColorScheme(.dark)
    }
}
#endif
