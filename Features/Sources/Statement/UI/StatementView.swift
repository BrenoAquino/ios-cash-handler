//
//  StatementView.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI
import DesignSystem

public struct StatementView: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        content
            .background(
                DSColor.background.rawValue.edgesIgnoringSafeArea(.all)
            )
            .navigationTitle(StatementLocalizable.title)
            .banner(data: $viewModel.banner.data, show: $viewModel.banner.show)
            .toolbar {
                addBar
            }
            .onAppear(perform: viewModel.fetchOperations)
    }
    
    // MARK: View State
    private var content: some View {
         ZStack {
             switch viewModel.state {
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
        List(viewModel.operations) { aggregator in
            Section {
                ForEach(aggregator.operations) { operation in
                    OperationCell(operation: operation)
                        .listRowSeparator(.hidden)
                        .listRowBackground(DSColor.clear.rawValue)
                        .listRowInsets(.init(top: DSSpace.smallM.rawValue,
                                             leading: DSSpace.smallL.rawValue,
                                             bottom: DSSpace.smallM.rawValue,
                                             trailing: DSSpace.smallL.rawValue))
                }
                .padding(.vertical, DSSpace.smallS.rawValue)
            } header: {
                HStack {
                    Text(aggregator.month)
                        .foregroundColor(DSColor.primaryText.rawValue)
                        .font(DSFont.headline2.rawValue)
                    
                    Text(aggregator.year)
                        .foregroundColor(DSColor.primaryText.rawValue)
                        .font(DSFont.footnote.rawValue)
                }
                .padding(.horizontal, DSSpace.smallL.rawValue)
            }
        }
        .padding(-20)
    }
}

#if DEBUG
// MARK: - Preview
import Previews

struct StatementView_Previews: PreviewProvider {
    static var previews: some View {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        return NavigationView {
            StatementView(viewModel: .init(operationsUseCase: OperationsUseCasePreview()))
        }
        .preferredColorScheme(.dark)
    }
}
#endif
